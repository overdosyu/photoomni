class PostsController < ApplicationController
  before_filter :find_topic, only: [:new, :edit, :update, :create]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])

    redirect_to :controller => :topics, :action => :show, :id => @topic.id
  end

  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    @post.topic = @topic
    @post.save

    redirect_to :controller => :topics, :action => :show, :id => @topic.id
  end


  private

  def find_topic
    @topic = Topic.find(params[:topic_id])
  end
end
