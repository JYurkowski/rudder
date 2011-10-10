module Admin
  def self.commands
    {
      /new room/i => lambda { add_room },
      /rooms/i => lambda { puts Room.all.collect(&:name).join("\n") }
    }
  end
  
  def add_room
    print 'Name: '
    name = gets.chomp;
    print 'Desc: '
    desc = gets.chomp
    
    Room.create({:name => name, :description => desc})
  end
end