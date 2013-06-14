namespace :report do
  task :create => :environment do
    PivotalReport.get_velocities_and_stories
    GithubReport.get_commits
    STDERR.puts "Report Complete: #{Time.now}"
  end
end
