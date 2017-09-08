require 'bundler'
Bundler.require

namespace :db do

  desc 'Populate db with random data and a test user'
	task :seed do
    puts "\nCreating data...\n"
	  ruby "./db/seeds.rb"
    puts "\nUsers created!\nTest user with pin=1234 and cpf=12345678910\n"
	end

  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    Sequel.extension :migration
    db_config = YAML.load_file(File.join(File.dirname(__FILE__), 'config', 'database.yml'))["development"]
    db = Sequel.connect(db_config.merge(logger: Logger.new("log/db.log")))
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
      puts "\nMigrations OK"
    end
  end

  desc 'Migrate and seed database'
  task prepare: [:migrate, :seed] do
    puts "\nReady to go!"
  end

end