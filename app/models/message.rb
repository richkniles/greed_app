class Message < ActiveRecord::Base
  
  attr_accessible :from_player, :to_player, :message
  
  validates :from_player, presence: true
  validates :to_player, presence: true
  validates :message, presence: true
  
  default_scope order: "created_at"
  
end
