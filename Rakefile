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
    rm 'db/development.db'
    Rake::Task['db:migrate'].invoke
  end
  
end

task :environment do
  require './lib/game'
  game = Game.instance
end