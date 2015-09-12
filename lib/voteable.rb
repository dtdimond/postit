module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end

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
