## TAILWINDCSS
## Install and configure TailwindCSS
if yes?("Would you like to install TailwindCSS?")
    gem 'tailwindcss-rails'
    run "./bin/rails tailwindcss:install"
end