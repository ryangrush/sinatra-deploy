RACK_ENV = ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, RACK_ENV)

connection_details = YAML::load(ERB.new(File.read('config/database.yml')).result)
ActiveRecord::Base.establish_connection(connection_details[RACK_ENV])

require_all 'app'