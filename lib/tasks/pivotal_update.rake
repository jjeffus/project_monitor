namespace :pivotal do
  task :update => :environment do
    PivotalReport.get_velocities_and_stories
  end
end
