#!/usr/bin/env ruby
# encoding: utf-8

require 'github_api'
require 'json'
require 'awesome_print'

@github = Github.new do |config|
  config.basic_auth = 'dcollazo:fark123'
  config.client_id = '22951bc3626814edf211'
  config.client_secret = '8390d6213cd2157a6e109c4f78288225509d910c'
end

organization = 'netversallc'
repo_names = []
collaborators = []

@github.repos.list(org:'netversallc').each do |repository|
  repo_names << /\/[a-zA-Z]*/.match(repository.full_name).to_s[1..-1].downcase
  repo_names.delete 'vitelity'
  repo_names.delete 'elance'
end

commit_count = Hash.new(0)


# get list of active collaborators in an organization
repo_names.each do |repo_name|
  @github.repos.collaborators.all('netversallc', repo_name).each do |collab| 
    collaborators << collab.login unless collaborators.include?(collab.login) 
  end
end

#get commits per developer
repo_names.each do |repo_name|
  @github.repos.commits.all('netversallc', repo_name).each do |commit|
  begin
    author = commit['author']['login']
  rescue
    next
  end
    commit_count[author] += 1
  end
  commit_count
end

ap commit_count