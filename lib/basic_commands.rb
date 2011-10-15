module BasicCommands
  
  def self.commands
    {
      /exit|quit/i => lambda { puts "Thanks for playing!".red; exit(0) },
      /hello/i => lambda { puts "You greet nobody in particular, and feel somewhat foolish after nobody returns the greeting.".red },
      /name/i => lambda { puts "Your name is #{player_character.name.blue}.".red }
    }
  end
end