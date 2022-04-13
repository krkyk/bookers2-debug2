class Book < ApplicationRecord
  is_impressionable #impressionistの機能を利用したい
  belongs_to :user
  has_many :favorites,dependent: :destroy
  has_many :favorited_users,through: :favorites,source: :user
  has_many :book_comments,dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}


  def favorited_by?(user)
    favorites.exists?(user_id:user.id)
  end

  def self.looks(method,word)
    if method=="perfect_match"
      Book.where("title LIKE?","#{word}")
    elsif method=="forward_match"
      Book.where("title LIKE?","#{word}%")
    elsif method=="backward_match"
      Book.where("title LIKE?","%#{word}")
    elsif method=="partial_match"
      Book.where("title LIKE?","%#{word}%")
    else
      Book.all
    end
  end

  scope:created_today,->{where(created_at:Time.zone.now.all_day)}#今日
  scope:created_yesterday,->{where(created_at:1.day.ago.all_day)}#昨日
  #scope:created_this_week,->{where(created_at:6.day)

end
