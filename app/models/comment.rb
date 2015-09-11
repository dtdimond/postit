class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :votes, as: :voteable

  validates :body, presence: true, allow_blank: false

  after_validation :generate_slug

  def total_votes
    up_boats - down_boats
  end

  def up_boats
    self.votes.where(vote: true).size
  end

  def down_boats
    self.votes.where(vote: false).size
  end

  def generate_slug
    self.slug = self.post.title.gsub(" ","-").downcase + "-comment-" + self.body.split.first.downcase
  end

  def to_param
    self.slug
  end
end
