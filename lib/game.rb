require 'bundler/setup'
require 'active_record'
require 'colorize'
Dir[File.join(File.dirname(__FILE__), '..', 'app', 'models', '*.rb')].each {|file| require file }

class Game
  
  @@response_table = {
   /exit|quit/i => lambda { exit(0) },
   /hello/i => lambda { puts "You greet nobody in particular, and feel somewhat foolish after nobody returns the greeting.".red },
   /name/i => lambda {|this| puts "Your name is #{this.player_character.name.blue}.".red },
   /(?:\Ai\Z)|(?:\Ainv\Z)|(?:inventory)/i => lambda { puts "What do you think this is, some sort of dungeon crawler? Really.".red }
  }
  
  
  def initialize
    ActiveRecord::Base.establish_connection({
        :adapter => 'sqlite3',
        :database => 'db/development.db',
        :pool => 5,
        :timeout => 5000
    })
    
    bootstrap_player_character!
    
    begin
      loop do
        print '=> '
        evaluate_input(gets.chomp)
      end
    rescue
      puts $@
      puts "Goodbye!"
    end
      
  end
  
  def evaluate_input(input)
    puts ""

    answer = @@response_table.find {|format, _| format.match input }
    if answer.nil?
      puts "I don't know how to do that."
    else
      case answer[1].arity
      when 0
        answer[1].call
      when 1
        answer[1].call(self)
      when 2
        answer[1].call(self, input)
      end
    end
  end
  
  def player_character
    @player_character ||= Character.player_character.first 
  end
  
  alias_method :pc, :player_character
  
  def bootstrap_player_character!
    c = Character.find_or_create_by_name_and_player("Rob", true)
  end
end