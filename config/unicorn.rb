root_path = '/srv/projects/store-monitor/current'
worker_processes 2
working_directory "#{root_path}"
listen "#{root_path}/tmp/sockets/unicorn.sock", :backlog => 512
timeout 30
pid "#{root_path}/tmp/pids/unicorn.pid"
stderr_path "#{root_path}/log/unicorn.stderr.log"
stdout_path "#{root_path}/log/unicorn.stdout.log"
before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{root_path}/Gemfile"
end

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.connection.disconnect!
  old_pid = root_path + '/tmp/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.establish_connection
end
