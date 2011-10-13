module Rooms
  def self.commands
    {
      /\Alook\Z/i => lambda { show_room }
    }.merge(self.directional_commands)
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
end