class AddDirectionsToRooms < ActiveRecord::Migration
  def self.up
    DIRECTIONS.each do |d|
      add_column :rooms, "#{d}_id", :integer
    end
  end
  
  def self.down
    DIRECTIONS.each do |d|
      remove_column :rooms, "#{d}_id".to_sym
    end
  end
  
end