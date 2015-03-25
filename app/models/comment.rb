class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  counter_culture :post

  validates :content, presence: true
end
