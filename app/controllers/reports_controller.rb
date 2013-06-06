class ReportsController < ApplicationController
  def index
    # @elance_data = ElanceReport.get_hours_worked_by_developer
    @github_data = GithubReport.get_commits
    @pivotal_data = PivotalReport.get_project_data
  end
  
  def show
  end
    
end
