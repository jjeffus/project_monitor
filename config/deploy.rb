require 'capistrano-db-tasks'
require 'bundler/capistrano'
require 'rvm/capistrano'
set :rvm_type, :user
# set :rails_env, "production"
set :db_local_clean, true

set :user, 'ubuntu'
set :domain, 'ec2-50-17-10-113.compute-1.amazonaws.com'
set :application, "reporting"
set :repository, "git@github.com:jjeffus/project_monitor.git"
set :deploy_to, "/home/ubuntu/reporting"
set :normalize_asset_timestamps, false
set :host, 'reporting.netversa.com'

role :app,  host
role :web,  host
role :db, host, :primary => true

# miscellaneous options
set :keep_releases, 5
set :default_shell, "bash -l"
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user
set :scm        , :git
set :use_sudo   , false
set :ssh_options, {:forward_agent => true}
#set :deploy_via, :remote_cache
#set :branch, 'master'
#set :scm_verbose, true

#default_run_options[:shell] = false
#default_run_options[:pty] = true


namespace :deploy do
  #desc 'Restarting server'
  #task :restart, :roles => :app, :except => { :no_release => true } do
    #run 'rvmsudo /etc/init.d/thin restart'
  #end

  #desc 'Stopping server'
  #task :stop, :roles => :app do
    #run 'rvmsudo /etc/init.d/thin stop'
  #end

  #desc 'Starting server'
  #task :start, :roles => :app do
    #run 'rvmsudo /etc/init.d/thin start'
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

namespace :thin do
  desc 'Restart Thin'
  task :restart do
    run 'rvmsudo /etc/init.d/reporting restart'
  end
end

after "deploy:finalize_update" do
  run ["ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml",
    "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml",
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
after 'nginx:reload'     , 'thin:restart'

require './config/boot'


