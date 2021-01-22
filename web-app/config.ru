require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end


require 'logger'
Logger.class_eval { alias :write :'<<' }
logger = ::Logger.new(::File.new("app.log","a+"))
 
configure do
  use Rack::CommonLogger, logger
end


use Rack::MethodOverride
use UsersController
run ApplicationController