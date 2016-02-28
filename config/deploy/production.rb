server '104.154.67.233',
         user: 'nazarchuk',
         roles: %w{web app db}

set :rails_env, 'production'
ask :branch, 'master'

set :deploy_to, '/srv/projects/notifyninja'

namespace :deploy do

  def execute_rake(task)
    within "#{current_path}" do
      with rails_env: fetch(:rails_env) do
        execute :rake, task
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  desc 'Start application'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:start'
    end
  end

  desc 'Stop application'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:stop'
    end
  end

end
