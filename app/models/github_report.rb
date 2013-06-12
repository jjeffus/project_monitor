#!/usr/bin/env ruby
# encoding: utf-8

class GithubReport < ActiveRecord::Base
	serialize :github_data, Hash

	def self.repo_commits
		@repo_commits
	end

	def self.member_commits
		@member_commits
	end

	def self.most_recent_commit
		@most_recent_commit
	end

	def self.get_commits
		@github = Octokit::Client.new(:login => "dcollazo", :password => "fark123")
		organization = 'netversallc'

		@most_recent_commit = {}
		@repo_commits = Hash.new(0)
		@member_commits = Hash.new(0)

		# parsed data
		commits = []
		repo_names = []
		last_commit = {}
		member_names = []
		github_commits = []
		github_last_commit = []

		# responses
		repos = @github.organization_repositories(organization)
		members = @github.org_members(organization)

		# Commit count for each repo in the past 24 hours
		commit_count = Hash.new(0)

		repos.each do |repository|
		  exclusion_list = ['vitelity_gem', 'elance_gem']
		  next if exclusion_list.include? repository.name
		  repo_names << repository.name.downcase
		  
		  # all commits in the past 24 hours
		  commits << ["#{repository.name.downcase}", @github.commits_since("#{organization}/#{repository.name}", "#{(Time.now - 86400).to_s[0..9]}")]
		end
		  
		commits.each do |commit_array|
		  repo = commit_array[0]
		  commit = commit_array[1]
		  @repo_commits[repo] = commit.size
		  last_commit[repo] = commit.first
		end

		commits.each_with_index do |commit_array, index|
		  # @member_commits[1][0]['author']['login'] += 1
		  commit_array[1].each do |commit|
		    begin
		      @member_commits[commit['author']['login']] += 1
		    rescue
		      next
		    end
		  end
		  @member_commits
		end

		repo_names.each do |repo_name|
		  commit_time = last_commit[repo_name]
		  next if commit_time.class == NilClass
		   @most_recent_commit[repo_name] = /\d\d:\d\d:\d\d/.match(commit_time['commit']['author']['date']).to_s
		end

		report = GithubReport.new
		report.save
	end
end

