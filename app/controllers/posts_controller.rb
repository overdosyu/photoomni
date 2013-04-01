class PostsController < ApplicationController
  before_filter :get_topic, only: [:new, :update, :create]

  # def index
  #   @posts = Post.all
  # end

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

    redirect_to :action => :show, :id => @post
  end

  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    @post.topic = @topic
    @post.save

    redirect_to :controller => :topics, :action => :show, :id => @topic.id
  end


  private

  def get_topic
    @topic = Topic.find(params[:topic_id])
  end
end
