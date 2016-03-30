server '46.101.206.241',
       user: 'deployer',
       roles: %w(web app db)

set :rails_env, 'production'
ask :branch, 'master'

set :deploy_to, '/srv/projects/store-monitor'

namespace :deploy do
  def execute_rake(task)
    within current_path.to_s do
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
