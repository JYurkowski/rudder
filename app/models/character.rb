class Character < ActiveRecord::Base
  belongs_to :room
  scope :player_character, lambda { where(:player => true) }
end