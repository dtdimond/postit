class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, :url, :description, presence: true

  def total_votes
    up_boats - down_boats
  end

  def up_boats
    self.votes.where(vote: true).size
  end

  def down_boats
    self.votes.where(vote: false).size
  end
end
