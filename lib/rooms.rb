module Rooms
  def self.commands
    [{
      /\Alook\Z/i => lambda { show_room }
    }, self.directional_commands, self.directional_aliases].inject(&:merge)
  end
  
  def self.directional_commands
    DIRECTIONS.inject({}) do |sum, dir|
      sum[/\A#{dir}\Z/] = lambda { send(dir.to_sym) }
      sum
    end
  end
  
  DIRECTIONS.each do |dir|
    define_method (dir.to_sym) do
      if pc.room.send("has_#{dir}_egress?".to_sym)
        pc.room = pc.room.send("#{dir}".to_sym)
        pc.save
        show_room
      else
        puts "You bump into a wall, and accidentally bite your tongue! Ow!".red
      end
    end
  end
  
  def show_room
    puts pc.room.name.blue 
    puts pc.room.description.red
    
    DIRECTIONS.each do |dir|
      if pc.room.send("has_#{dir}_egress?".to_sym)
        puts (dir.capitalize + ": " + pc.room.send("#{dir}".to_sym).name.blue) 
      end
    end
  end
  
  def self.directional_aliases
    {:sw => :southwest, :w => :west, :nw => :northwest, :n => :north, :ne => :northeast, :e => :east, :se => :southeast, :s => :south}.inject({}) do |sum, (short, long)|
      alias_method short, long
      sum[/\A#{short}\Z/] = lambda { send(short.to_sym) }
      sum
    end
  end
end