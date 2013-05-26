#!/usr/bin/env ruby
# encoding: utf-8

class GithubReport
  def self.get_commits
    @github = Github.new do |config|
    end
    @github.repos.commits(org:'newtversallc', repo:'contact')
  end
end
