class AddPlayerToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :player, :boolean
  end
  
  def self.down
    remove_column :characters, :player
  end
  
end