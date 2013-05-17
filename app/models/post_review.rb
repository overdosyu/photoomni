class PostReview < ActiveRecord::Base
  attr_accessible :rating, :comment

  belongs_to :post
  belongs_to :user
end
