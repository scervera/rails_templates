## To use this template file run the rails new command like this:
## rails new app-name -m template.rb

## To install a specific version of rails AND this template use the command below:
## rails _version_ new app-name -m template.rb

# require "bundler"
# require "json"
# RAILS_REQUIREMENT = "~> 7.0.0".freeze

## --------------------------------------------------------------------- ##

## Install gems
gem_group :development do
    gem "capistrano", "~> 3.10", require: false
    gem "capistrano-rails", "~> 1.6", require: false
    gem 'annotate'
    # gem 'meta_request', '~> 0.7.3'  Note: This is not compatible with Rails 7+
end

gem_group :development, :test do
    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
    gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
gem 'pundit'
gem 'better_errors'
gem 'binding_of_caller'
gem 'pry'
gem 'amazing_print'
gem 'sidekiq'
gem 'ransack'

## --------------------------------------------------------------------- ##

## ACTIVE STORAGE
## Install and configure Active Storage
if yes?("Would you like to install Active Storage?")
    rails_command "active_storage:install"
    # rails_command "db:migrate"
end

## --------------------------------------------------------------------- ##

## DEVISE AUTHENTICATION
## Install and configure Devise authentication
if yes?("Would you like to install Devise?")
    gem "devise"
    generate "devise:install"
    model_name = ask("What would you like the user model to be called? [user]")
    model_name = "user" if model_name.blank?
    generate "devise", model_name
end

if yes?("Would you like to copy Devise views to your project?")
    rails_command "rails generate devise:views"
end

## add devise configuration to config/environments/development.rb
environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'

## --------------------------------------------------------------------- ##

## TAILWINDCSS
## Rails 7 now incluses the -css option to install different css frameworks
## Currently, this generator supports the options tailwind, bootstrap, bulma, sass, and postcss
## rails new myapp --css tailwind
## Install and configure TailwindCSS
# if yes?("Would you like to install TailwindCSS?")
#     gem 'tailwindcss-rails'
#     run "./bin/rails tailwindcss:install"
# end



## Finish Up
rails_command "db:migrate"