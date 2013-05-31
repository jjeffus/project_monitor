#!/usr/bin/env ruby
# encoding: utf-8

class ElanceReport
  def self.get_hours_worked_by_developer
    Elance::Freelancer.Elancemy do |freelancers|
      freelancers['data']['agents'].each do |agent|
        elance_data = [ [agent['userId'], agent['userDisplayName'], agent['companyDisplayName'], agent['screenData']['bidData']['hourlyRate'], agent['hoursToday'], agent['hours'], agent['authorizedHours']].join("\t") ]
      end
    end
    elance_data
  end
end
