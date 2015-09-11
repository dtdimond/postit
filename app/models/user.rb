class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false, unique: true

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 4}

  after_validation(:generate_slug)

  def generate_slug
    self.slug = self.username.gsub(" ","-").downcase
  end

  def to_param
    self.slug
  end
end
