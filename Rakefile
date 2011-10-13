require 'bundler/setup'
require 'active_record'

task :default => 'install'

desc "Creates database + schema and walks through basic settings to get bootstrapped."
task :install => :environment do
  puts "Migrating the database..."
  Rake::Task['db:migrate'].invoke
end


namespace :db do
  desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
  task :migrate => :environment do
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end
  
  desc "Resets the database."
  task :reset do
    rm File.join(File.dirname(__FILE__), 'db', 'development.db')
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end
  
  desc "Creates a basic set of data for testing purposes."
  task :seed => :environment do
    Dir[File.join(File.dirname(__FILE__), 'db', 'seeds', '*.rb')].each do |file|
      puts "Loading #{file} seed..."
      load file 
    end
  end

    
  
end

task :environment do
  require './lib/game'
  game = Game.instance
end