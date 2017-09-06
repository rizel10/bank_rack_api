require 'yaml'
require 'mysql2'
require 'sequel'
require 'faker'

a = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'config', 'database.yml'))["development"]
DB = Sequel.connect(a)

accounts = DB[:accounts]
users = DB[:users]
operations = DB[:operations]


30.times do
  accounts.insert({ account_number: Random.rand(1000..9999), current_balance: Random.rand(0.0..1000.0) })
end

accounts.all.each{ |a| users.insert(account_number: a[:account_number], name: Faker::Name.name, cpf: Random.rand(00000000000..99999999999), pin: Random.rand(0000..9999)) }

users.all.each do |u|
  10.times do 
    operations.insert({ user_id: u[:id], operation_type: Random.rand(0..1), amount: Random.rand(0.00..100.00) })
  end
  
end