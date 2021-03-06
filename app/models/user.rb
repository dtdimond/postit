class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false, unique: true

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 4}
  sluggable_column(:username)

end
