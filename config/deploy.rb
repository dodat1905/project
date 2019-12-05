lock "~> 3.11.0"

set :application, "project"
set :repo_url, "git@github.com:dodat1905/project.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :pty, true
set :linked_files, %w(config/database.yml .env)
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads public/pdfs)
set :keep_releases, 5
set :rvm_type, :user

set :puma_rackup, -> {File.join(current_path, "config.ru")}
set :puma_state, -> {"#{shared_path}/tmp/pids/puma.state"}
set :puma_pid, -> {"#{shared_path}/tmp/pids/puma.pid"}
set :puma_bind, -> {"unix://#{shared_path}/tmp/sockets/puma.sock"}
set :puma_conf, -> {"#{shared_path}/puma.rb"}
set :puma_access_log, -> {"#{shared_path}/log/puma_access.log"}
set :puma_error_log, -> {"#{shared_path}/log/puma_error.log"}
set :puma_role, :app
set :puma_threads, [0, 8]
set :puma_workers, 1
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false


namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc 'Restart application'
  # task :restart do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     Rake::Task["puma:restart"].reenable
  #     invoke 'puma:restart'
  #   end
  # end

  after  :finishing,    :restart
end

