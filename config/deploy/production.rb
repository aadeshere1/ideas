# config/deploy/production.rb
server '43.207.0.155', user: 'ubuntu', roles: %w{app db web}, primary: true

set :ssh_options, {
  keys: %w(/Users/senengutami/Desktop/re_ssh.pem),
  forward_agent: true,
  auth_methods: %w(publickey)
}

# Set environment for production
set :rails_env, 'production'
set :puma_env,  'production'
