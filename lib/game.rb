DIRECTIONS = %w(northwest north northeast east southeast south southwest west up down in out)

require 'bundler/setup'
require 'active_record'
require 'colorize'
require 'singleton'
require './lib/basic_commands.rb'
require './lib/admin.rb'
require './lib/rooms.rb'
require './lib/items.rb'

Dir[File.join(File.dirname(__FILE__), '..', 'app', 'models', '*.rb')].each {|file| require file }



class Game
  include Singleton
  include BasicCommands
  include Admin
  include Rooms
  include Items
  
  attr_accessor :response_table
  
  def initialize
  
    @response_table = [{/\Aev (.*)\Z/ => lambda {|str| puts eval(str).to_s.green }}, BasicCommands.commands, Admin.commands, Rooms.commands, Items.commands].inject(&:merge)
  
    ActiveRecord::Base.establish_connection({:adapter => 'sqlite3', :database => 'db/development.db'})
  end
  
  def go!
    loop do
      begin
        print '-> '
        evaluate_input(gets.chomp)
      rescue => detail
        puts "===================================================".red
        puts detail.to_s.light_red
        puts detail.backtrace.join("\n").red
        next
      end
    end
  end
  
  def evaluate_input(input)
    puts ""

    answer = @response_table.find {|format, _| format.match input }
    if answer.nil?
      puts "I don't know how to do that."
    else
      if answer[1].arity >= 1
        instance_exec(*($~.captures), &answer[1])
      else
        instance_exec(&answer[1])
      end
    end
  end
  
  def player_character
    @player_character ||= Character.player_character.first 
  end
  
  alias_method :pc, :player_character
end