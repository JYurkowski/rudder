module Items
  
  def self.commands
    {
      /(?:\Ai\Z)|(?:\Ainv\Z)|(?:inventory)/i => lambda { show_inventory },
      /take (\S+)/ => lambda {|name| take_object(name)},
      /drop (\S+)/ => lambda {|name| drop_object(name)}
    }
  end
  
  def take_object(name)
    if (item = pc.room.items.find(:first, :conditions => [ "lower(name) LIKE ?", "%#{name.downcase}%"]))
      item.nestable_type = 'Character'
      item.nestable_id = pc.id
      pc.items << item
      puts "Taken" if item.save! && pc.save!
    else
      puts "You don't see that item here.".red
    end
  end
  
  def drop_object(name)
    if (item = pc.items.find(:first, :conditions => [ "lower(name) LIKE ?", "%#{name.downcase}%"]))
      item.nestable_type = 'Room'
      item.nestable_id = pc.room.id
      pc.items -= [item]
      # pc.room.items << item
      # puts "Dropped.".red if item.save! && pc.save! && pc.room.save!
      puts "Dropped." if item.save!
    else
      puts "You don't have that object in your possession.".red
    end
  end
  
  
  def show_inventory
    puts "Your inventory contains: ".red
    pc.items.each do |item|
      puts "- #{item}".light_red
    end
    
    puts "- Nothing.".light_red if pc.items.count == 0
  end
end