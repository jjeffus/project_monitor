namespace :report do
  task :create => :environment do
    Report.generate
  end
end
