class Item < ActiveRecord::Base
  belongs_to :nestable, :polymorphic => true
  has_many :items, :as => :nestable
  
  def to_s
    name.capitalize
  end
end