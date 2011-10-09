class Character < ActiveRecord::Base
  scope :player_character, lambda { where(:player => true) }
end