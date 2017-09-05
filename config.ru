require 'bundler'
Bundler.require

require File.join(File.dirname(__FILE__),'lib', 'bank_rack')
require File.join(File.dirname(__FILE__),'lib', 'request_controller')

BankRackApplication = BankRack.new

# Load the routes
require File.join(File.dirname(__FILE__),'config', 'routes')

run RequestController.new