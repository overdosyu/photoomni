class Post < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :user
  belongs_to :topic

  has_one :post_review
  has_many :post_likes

  attr_accessible :content, :photo

  # PostgreSQL default order is 'id desc'
  scope :recent_updated, order('updated_at DESC')

  alias_method :review, :post_review
  alias_method :likes, :post_likes

  delegate :title, :to => :topic, :allow_nil => true

  has_attached_file :photo,
    :styles => {
      :size_640_by => "640x",
      :size_300_by => "300x" },
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "post/photo/:style/:id/:filename",
    :default_url => "post/photo/:style/missing.jpg"


  def url
    edit_topic_post_path(topic.id, id)
  end

end
