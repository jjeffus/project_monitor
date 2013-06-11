#!/usr/bin/env ruby
# encoding: utf-8

class GithubReport < ActiveRecord::Base

	@github_commits = []
	@github_last_commit = []

	def self.commits
		@github_commits
	end

	def self.last_commit_time
		@github_last_commit
	end

  def self.get_commits
		@github = Github.new do |config|
		  config.basic_auth = ENV["GITHUB_BASIC_AUTH"]
		  config.client_id = ENV["GITHUB_CLIENT_ID"]
		  config.client_secret = ENV["GITHUB_CLIENT_SECRET"]
		end

		organization = 'netversallc'
		repo_names = []
		collaborators = []
		commit_count = Hash.new(0)

    ap ["Github", @github]
    ap ["Repos", @github.repos]

		@github.repos.list(org:'netversallc').each do |repository|
		  repo_names << /\/[a-zA-Z]*/.match(repository.full_name).to_s[1..-1].downcase
		  repo_names.delete 'vitelity'
		  repo_names.delete 'elance'
		end

		# get list of collaborators across an organization
		repo_names.each do |repo_name|
		  @github.repos.collaborators.all('netversallc', repo_name).each do |collab| 
		    collaborators << collab.login unless collaborators.include?(collab.login) 
		  end
		end

		#get list of commits in a repository
		repo_names.each do |repo_name|
		  @github.repos.commits.all('netversallc', repo_name).each do |commit|
		  
		  begin
		    author = commit['author']['login']
		  rescue
		    next
		  end

		    commit_count[author] += 1
		  end
		end
		commit_count
  end

end
