class Report
  def self.generate
    @elance  = ElanceReport.get_hours_worked_by_developer
    @pivotal = PivotalReport.get_project_data
    @github  = GithubReport.get_commits
    report = self.new
    report.elance = elance
    report
  end
  def self.latest
    Report.order(:create_at).first
  end
end
