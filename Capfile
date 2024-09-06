
require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/rails"
require "capistrano/bundler"
require "capistrano/rbenv"
require "capistrano/puma"
require "capistrano/puma/workers"
require "capistrano/puma/jungle"
require "capistrano/puma/nginx"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
