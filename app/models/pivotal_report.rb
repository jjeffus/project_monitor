#!/usr/bin/env ruby
# encoding: utf-8

class PivotalReport < ActiveRecord::Base

	@open_stories = []
	@velocities = []

	def self.open_stories
		@open_stories
	end

	def self.velocities
		@velocities
	end

	def self.get_velocities_and_stories
		PivotalTracker::Client.token = ENV["PIVOTAL_TOKEN"]
		project_velocities = []
		open_stories = []

		@projects = PivotalTracker::Project.all
		@projects.each do |project|
		  project_velocities << {project.name => project.current_velocity}
		  project.stories.all.each do |story|
		    open_stories << story.name if story.current_state == "started"
		  end
		  @open_stories = open_stories.dup
		end
		@velocities = project_velocities.dup
	end

end

