## DEVISE AUTHENTICATION
## Install and configure Devise authentication
if yes?("Would you like to install Devise?")
    gem "devise"
    generate "devise:install"
    model_name = ask("What would you like the user model to be called? [user]")
    model_name = "user" if model_name.blank?
    generate "devise", model_name
end

## add devise configuration to config/environments/development.rb
environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'