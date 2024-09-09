# config/deploy/production.rb
server '18.234.56.119', user: 'deployer', roles: %w{app db web}, primary: true

set :ssh_options, {
  keys: %w(/Users/senengutami/Desktop/personal_ssh.pem),
  forward_agent: true,
  auth_methods: %w(publickey)
}

# Set environment for production
set :rails_env, 'production'
set :puma_env,  'production'
