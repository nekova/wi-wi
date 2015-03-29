class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, touch: true
  counter_culture :post

  validates :content, presence: true
end
