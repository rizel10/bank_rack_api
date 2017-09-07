require 'bundler'
Bundler.require

a = YAML.load_file(File.join(File.dirname(__FILE__), 'config', 'database.yml'))["development"]
Sequel::Model.db = Sequel.connect(a)
Sequel::Model.plugin :timestamps, update_on_create: true
Sequel::Model.plugin :json_serializer

require File.join(File.dirname(__FILE__),'lib', 'string')
require File.join(File.dirname(__FILE__),'lib', 'bank_rack')
require File.join(File.dirname(__FILE__),'lib', 'request_controller')


BankRackApplication = BankRack.new

# Load the routes
require File.join(File.dirname(__FILE__),'config', 'routes')

run RequestController.new