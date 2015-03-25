class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :comments
  has_many :posts

  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 32 },
    format: { with: /\A[a-z0-9_]{1,32}\Z/}
  validates :email,
    presence: true,
    uniqueness: true,
    email: {strict_mode: :true}
  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
end
