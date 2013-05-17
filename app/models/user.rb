class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation

  has_one :user_profile, dependent: :destroy
  has_many :topics
  has_many :posts

  has_many :post_reviews
  has_many :post_likes

  alias_method :profile, :user_profile

  delegate :avatar, to: :user_profile, :allow_nil => true

  before_create :build_default_user_profile

  acts_as_authentic

  def display_name
    if profile.present? && profile.full_name.present?
      profile.full_name
    else
      email
    end
  end

  def rating
    sum = 0
    count = 0
    posts.each do |post|
      if post.try(:review).try(:rating)
        sum += post.review.rating
        count += 1
      end
    end
    sum==0 ? 0 : (sum.to_f/count).ceil
  end

  # count of likes come from others
  def likes_count
    count = 0
    p posts
    posts.each do |post|
      p post.likes
      if post.likes
        count += post.likes.size
      end
    end
    count
  end

  private
  def build_default_user_profile
    build_user_profile
    true
  end

end
