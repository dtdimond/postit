class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :votes, as: :voteable

  validates :body, presence: true

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
