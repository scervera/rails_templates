# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "myapp"  # change application name
set :repo_url, "git@github.com:scervera/calvarychapel-tesol-app.git" #change git repo url


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/myapp"  # change web root path

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

append :linked_files, "config/master.key"

namespace :deploy do
  namespace :check do
    # this checks to see if there is a master.key file on the server. If not, it copies the local file to the server.
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! 'config/master.key', "#{shared_path}/config/master.key"
        end
      end
    end
    # this checks to see if there is a database.yml file on the server. If not, it copies the local file to the server.
    before :linked_files, :set_database_yml do
        on roles(:db), in: :sequence, wait: 10 do
          unless test("[ -f #{shared_path}/config/database.yml ]")
            upload! 'config/database.yml', "#{shared_path}/config/database.yml"
          end
        end
    end
  end

  ## this is a custom rake action that enables seeding a production database with the seed file. USE CAREFULLY!
  desc "reload the database with seed data"
  task :seed do
    on roles(:all) do
      within current_path do
        execute :bundle, :exec, 'rails', 'db:seed', 'RAILS_ENV=production'
      end
    end
  end

end


