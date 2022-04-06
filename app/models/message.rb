class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  # validates :content,precence:true,length:{maxmum:140}
end
