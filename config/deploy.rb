set :application, "webcapistrano"
#set :repository,  "set your repository location here"
#
set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#set :user, 'deploy'

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
role :app, "localhost"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
load "config/shared/custom_config"

default_run_options[:pty]=true
set :captain_home, "/home/cworsnup/projects/kombat/current"
set :repository, "git@github.com:bbmobile/webcapistrano.git"
set :deploy_to, "/home/cworsnup/projects/kombat"
set :ssh_options, { :forward_agent => true }

task :update, roles => [:app] do
  transaction do
    update_code
    symlink
  end
end

task :update_code, roles => [:app] do
  run "git clone #{repository} #{release_path}"
  #run "mkdir #{release_path}/tmp"
end

task :symlink, roles => [:app] do
  sudo "ln -nfs #{release_path} #{captain_home}"
end


