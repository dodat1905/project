set :stage, :production
set :rails_env, :production
set :deploy_to, "/var/www/project"
set :branch, :develop
set :puma_env, fetch(:rack_env, fetch(:rails_env, "production"))
server "118.70.242.172", user: "dodat", roles: %w(web app db), primary: true
