class Comment < ActiveRecord::Base
  include Voteable
  include Sluggable

  belongs_to :post
  belongs_to :user

  validates :body, presence: true, allow_blank: false
  sluggable_column :body
end
