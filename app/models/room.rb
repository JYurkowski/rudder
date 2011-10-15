class Room < ActiveRecord::Base
  has_many :characters
  has_many :items, :as => :nestable
    
  DIRECTIONS.each do |direction|
    belongs_to direction.to_sym, :class_name => "Room"
    
    define_method "has_#{direction}_egress?".to_sym do
      !send("#{direction}_id").nil?
    end
  end
end