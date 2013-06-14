class ReportsController < ApplicationController
	def index
    @pivotal_report     = PivotalReport.last
    @github_report      = GithubReport.last

    @open_stories       = @pivotal_report.stories
		@velocities         = @pivotal_report.velocities
    @repo_commits       = @github_report.repo_commits
    @member_commits     = @github_report.member_commits
    @most_recent_commit = @github_report.most_recent_commit
	end
end
