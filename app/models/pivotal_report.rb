#!/usr/bin/env ruby
# encoding: utf-8

class PivotalReport < ActiveRecord::Base
	serialize :pivotal_data, Hash

  def velocities
  	self.pivotal_data['velocities']
  end
  def stories
  	self.pivotal_data['stories']
  end
  
	def self.get_velocities_and_stories
		PivotalTracker::Client.token = ENV["PIVOTAL_TOKEN"]
		pivotal_data = {}
		project_velocities = []
		open_stories = []

		projects = PivotalTracker::Project.all
		projects.each do |project|
		  project_velocities << {project.name => project.current_velocity}
		  project.stories.all.each do |story|
		    open_stories << story.name if story.current_state == "started"
		  end
		  open_stories = open_stories.dup
		  pivotal_data['stories'] = open_stories
		end
		velocities = project_velocities.dup
		pivotal_data['velocities'] = velocities

		report = PivotalReport.new
		report.pivotal_data = pivotal_data
		report.save
	end
end

