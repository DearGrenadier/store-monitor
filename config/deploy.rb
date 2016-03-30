# config valid only for current version of Capistrano
lock '3.4.0'

set :rvm_type, :user
set :rvm_ruby_version, '2.3.0'
set :rvm_roles, :all # default value

set :application, 'store-monitor'
set :repo_url, 'git@github.com:cosmosloth/store-monitor.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/srv/projects/store-monitor'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

set :unicorn_config_path, -> { "#{fetch(:deploy_to)}/current/config/unicorn.rb" }

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc 'Configure nginx files'
  task :configure_nginx do
    on roles(:web), in: :sequence, wait: 2 do
      execute "sudo cp #{current_path}/nginx/nginx_conf.conf /etc/nginx/sites-enabled/ && sudo /etc/init.d/nginx reload"
    end
  end

  desc 'Runs rake db:seed'
  task seed: [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end
  after :publishing, :configure_nginx

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
