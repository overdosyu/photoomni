class TopicsController < ApplicationController
  def new
    @post = Post.new
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def create
    post_params = params[:post]
    title = post_params.delete(:title)

    Topic.transaction do
      topic = Topic.new(:title => title)
      topic.user = current_user
      topic.save

      post = Post.new(post_params)
      post.user = current_user
      post.topic_id = topic.id
      post.save
    end

    redirect_to root_url
  end

end
