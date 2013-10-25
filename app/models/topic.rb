class Topic < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_many :posts, :order => :id
  attr_accessible :title

  def url
    topic_path(id)
  end
end
