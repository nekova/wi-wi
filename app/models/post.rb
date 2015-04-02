class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  # accepts_nested_attributes_for :comments
  acts_as_votable


  validates :title,
    presence: true,
    length: { maximum: 120 }
  validates :url,
    presence: true,
    url: true
end
