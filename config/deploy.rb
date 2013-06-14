require 'capistrano-db-tasks'
require 'bundler/capistrano'
require 'rvm/capistrano'
set :rvm_type, :user
# set :rails_env, "production"
set :db_local_clean, true
# set :rvm_type, :deploy
# set :rvm_type, :system
# set :rvm_bin_path, "/home/deploy/.rvm/bin"

set :deploy_to, '/home/ubuntu/contact'
set :keep_releases, 5
set :default_shell, "bash -l"
set :rvm_ruby_string, '2.0'
set :rvm_type, :user

set :application, 'reporting'
set :scm        , :git
set :repository , 'git://github.com/jjeffus/project_monitor.git'
set :user       , 'ubuntu'
set :use_sudo   , false

def production_prompt
  puts "\n\e[0;31m   ######################################################################"
  puts "   #\n   #       Are you REALLY sure you want to deploy to production?"
  puts "   #\n   #               Enter y/N + enter to continue\n   #"
  puts "   ######################################################################\e[0m\n"
  proceed = STDIN.gets[0..0] rescue nil
  exit unless proceed == 'y' || proceed == 'Y'
end

def staging_prompt
  puts "\n\e[0;31m   ######################################################################"
  puts "   #\n   #       Deploy to staging?     "
  puts "   ######################################################################\e[0m\n"
  proceed = STDIN.gets[0..0] rescue nil
  exit unless proceed == 'y' || proceed == 'Y'
end

desc 'Run tasks in new production enviroment.'
task :production do
  production_prompt
  set  :rails_env ,'production'
  set  :branch    ,'production'
  set  :host      , ENV['PRODUCTION_SERVER']
  role :app       ,host
  role :web       ,host
  role :db        ,host, :primary => true
end

task :staging do
  staging_prompt
  set  :rails_env ,'production'
  set  :branch    ,'master'
  set  :host      , ENV['STAGING_SERVER']
  role :app       ,host
  role :web       ,host
  role :db        ,host, :primary => true
end

namespace :deploy do
  #desc 'Restarting server'
  #task :restart, :roles => :app, :except => { :no_release => true } do
    #run 'rvmsudo /etc/init.d/unicorn restart'
  #end

  #desc 'Stopping server'
  #task :stop, :roles => :app do
    #run 'rvmsudo /etc/init.d/unicorn stop'
  #end

  #desc 'Starting server'
  #task :start, :roles => :app do
    #run 'rvmsudo /etc/init.d/unicorn start'
  #end

  desc 'Running migrations'
  task :migrations, :roles => :db do
    run "cd #{release_path} && bundle exec rake db:migrate RAILS_ENV=#{rails_env}"
  end

  desc 'Building assets'
  task :assets do
    run "cd #{release_path} && bundle exec rake assets:precompile"
  end
end

namespace :nginx do
  desc 'Reload Nginx'
  task :reload do
    sudo '/etc/init.d/nginx reload'
  end
end

namespace :unicorn do
  desc 'Restart Unicorn'
  task :restart do
    run 'rvmsudo /etc/init.d/contact restart'
  end
end

after "deploy:finalize_update" do
  run ["ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml",
       "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml",
       "ln -nfs #{shared_path}/config/unicorn.rb #{release_path}/config/unicorn.rb"
  ].join(" && ")
end

task :after_update_code do
  %w{labels}.each do |share|
    run "ln -s #{shared_path}/#{share} #{release_path}/#{share}"
  end
end

after 'deploy'           , 'deploy:migrations'
after 'deploy:migrations', 'deploy:assets'
after 'deploy:assets',     'after_update_code'
after 'after_update_code', 'nginx:reload'
after 'nginx:reload'     , 'unicorn:restart'

require './config/boot'
