class Character < ActiveRecord::Base
  belongs_to :room
  has_many :items, :as => :nestable
  
  scope :player_character, lambda { where(:player => true) }
end