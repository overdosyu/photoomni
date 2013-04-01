class Post < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :user
  belongs_to :topic

  attr_accessible :content, :photo

  delegate :title, :to => :topic, :allow_nil => true

  has_attached_file :photo,
    :styles => {
      :size_640_by => "640x",
      :size_300_by => "300x" },
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "post/photo/:style/:id/:filename"


  def url
    topic_post_path(topic.id, id)
  end

end
