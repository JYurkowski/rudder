module Rooms
  def self.commands
    {
      /\Alook\Z/i => lambda { puts pc.room.name.blue; puts pc.room.description.red }
      
    }
  end
end