class AddRoomIdToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :room_id, :integer
  end
  
  def self.down
    remove_column :characters, :room_id
    
  end
end