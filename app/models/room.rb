class Room < ActiveRecord::Base
  has_many :characters
end