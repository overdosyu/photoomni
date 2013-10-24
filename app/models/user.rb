class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :confirmable, and :activatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :provider, :uid

  has_one :user_profile, dependent: :destroy
  has_many :topics
  has_many :posts

  has_many :post_reviews
  has_many :post_likes

  alias_method :profile, :user_profile

  delegate :avatar_url, to: :user_profile, :allow_nil => true

  before_create :build_default_user_profile

  # acts_as_authentic

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

  def avatar_url(size)
    profile.avatar_url(size)
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

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      # name: auth.extra.raw_info.name,
      user = User.create(provider: auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
                         password: Devise.friendly_token[0,20])
    end
    user.profile.update_attributes(:first_name => auth.extra.raw_info.first_name, :last_name => auth.extra.raw_info.last_name)
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private
  def build_default_user_profile
    build_user_profile
    true
  end

end
