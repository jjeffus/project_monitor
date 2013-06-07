class PivotalReport
  include Mongoid::Document
  
  def self.get_project_data
    pivotal_data = []
    @projects = PivotalTracker::Project.all
    @projects.each do |project|
      project.stories.all.each do |story|
        pivotal_data << story if story.current_state == "started"
      end
    end
    pivotal_data
  end
  
end