class Book < ApplicationRecord
  is_impressionable #impressionistの機能を利用したい
  belongs_to :user
  has_many :favorites,dependent: :destroy
  has_many :favorited_users,through: :favorites,source: :user
  has_many :book_comments,dependent: :destroy
  has_many :book_tags,dependent: :destroy
  has_many :tags,through: :book_tags
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

  scope:created_today,->{where(created_at:Time.zone.now.all_day)}
  scope:created_yesterday,->{where(created_at:1.day.ago.all_day)}
  scope:created_this_week,->{where(created_at:6.day.ago.beginning_of_day..Time.zone.now.end_of_day)}
  scope:created_last_week,->{where(created_at:2.week.ago.beginning_of_day..1.week.ago.end_of_day)}

  scope:latest,->{order(created_at: :desc)}
  scope:star_count,->{order(rate: :desc)}

  def save_tag(sent_tags)
    current_tags=self.tags.pluck(:name) unless self.tags.nil?
    old_tags=current_tags-sent_tags
    new_tags=sent_tags-current_tags
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name:old)
    end
    new_tags.each do |new|
      new_book_tag=Tag.find_or_create_by(name:new)
      self.tags << new_book_tag
    end
  end
end
