#!/usr/bin/env ruby
# encoding: utf-8

class PivotalReport
  def self.get_project_info
    pivotal_data = []
    @projects = PivotalTracker::Project.all
    @projects.each do |project|
      project.self.stories.all.each do |story|
        pivotal_data << output if story.current_state == "started"
      end
    end
    pivotal_data
  end
end
