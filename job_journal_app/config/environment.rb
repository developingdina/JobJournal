ENV['SINATRA_ENV'] ||= "development"

if ENV['SINATRA_ENV'] == "development"
  require_relative "../../secrets.rb"
end

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require './app/controllers/application_controller'
require_all 'app'

