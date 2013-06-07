class GithubReport
  include Mongoid::Document
  
  def self.get_commits
    @github = Github.new do |config|
    end
    @github.repos.commits(org:'netversallc', repo:'contact')
  end
  
end
