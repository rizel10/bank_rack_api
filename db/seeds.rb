require 'bundler'
Bundler.require

a = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'config', 'database.yml'))["development"]
Sequel::Model.db = Sequel.connect(a)
Sequel::Model.plugin :timestamps, update_on_create: true

# Dir[File.dirname(__FILE__) + '/../app/models/*.rb'].each {|file| require file }

require File.join(File.dirname(__FILE__),'..', 'app', 'models', 'account')
require File.join(File.dirname(__FILE__),'..', 'app', 'models', 'user')
require File.join(File.dirname(__FILE__),'..', 'app', 'models', 'operation')


30.times do |i|
  Account.create({ account_number: 1000 + i, current_balance: Random.rand(0.0..1000.0) })
end

Account.all.each{ |a| User.create(account: a, name: Faker::Name.name, cpf: Random.rand(10000000000..99999999999).to_s, pin: Random.rand(1000..9999).to_s) }

User.all.each do |u|
  10.times do 
    op_type = Operation.operation_types.sample
    if op_type == :deposit
      acc = Account.all.sample
    elsif op_type == :withdraw
      acc = u.account
    end
    Operation.create({ user: u, account: acc, operation_type: op_type, amount: Random.rand(0.00..100.00) })
  end  
end

user = User.first
user.pin = "1234"
user.cpf = "12345678910"
user.save

account = user.account
account.account_number = 4955
account.save