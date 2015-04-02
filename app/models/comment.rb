class Comment < ActiveRecord::Base
  include Vote

  belongs_to :user
  belongs_to :post, touch: true
  counter_culture :post
  acts_as_votable

  validates :content, presence: true
end
