# config valid for current version and patch releases of Capistrano
lock "~> 3.19.1";

set :application, "ideas"

set :repo_url, "https://github.com/aadeshere1/ideas.git"

set :deploy_to, "/var/www/ideas"
set :branch, "main"

set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma_access.log"
set :puma_error_log,  "#{release_path}/log/puma_error.log"
set :puma_preload_app, true
set :puma_worker_timeout, 60
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

# Capistrano settings
set :linked_files, %w{config/database.yml config/master.key}
set :linked_dirs,  %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

set :rbenv_type, :user
set :rbenv_ruby, '3.3.1' # Set this to your Ruby version

namespace :puma do
  desc 'Create Directories for Puma Pids and Sockets'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/tmp/sockets #{shared_path}/tmp/pids"
    end
  end
end

namespace :deploy do
  desc 'Upload database.yml to shared/config'
  task :upload_config do
    on roles(:app) do
      # Ensure the config directory exists
      execute :mkdir, "-p #{shared_path}/config"

      # Upload the database.yml file from the local machine to the shared/config directory on the server
      upload!('config/database.yml', "#{shared_path}/config/database.yml")
      upload!('config/master.key', "#{shared_path}/config/master.key")
    end
  end
end

before 'deploy:check:linked_files', 'deploy:upload_config'
before 'deploy:restart', 'puma:make_dirs'
after 'deploy:publishing', 'deploy:restart'
after 'deploy:restart', 'puma:restart'
# before 'deploy:migrate', 'db:create'