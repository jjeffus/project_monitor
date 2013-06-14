#!/usr/bin/env ruby
# encoding: utf-8

class ElanceReport < ActiveRecord::Base

  @elance_data = []

  def elance_data
  	@elance_data
  end

  def self.get_hours_worked_by_developer
    elance = Elance::Freelancer.new(elance_token)
    elance.my do |freelancers|
      freelancers['data']['agents'].each do |agent|
        @elance_data = [ [agent['userId'], agent['userDisplayName'], agent['companyDisplayName'], agent['screenData']['bidData']['hourlyRate'], agent['hoursToday'], agent['hours'], agent['authorizedHours']].join("\t") ]
      end
    end
    @elance_data
  end
  
end