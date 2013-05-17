class PostLikesController < ApplicationController
  before_filter :find_post, only: [:create, :destroy]

  # respond_to :html, :js
  respond_to :js

  def show
    respond_with(@post.likes.count)
  end

  def create
    p "CCCCCCCC"
    begin
      post_like = PostLike.new
      post_like.post_id = @post.id
      post_like.user_id = current_user.id
      post_like.save and flash[:notice] = "Like this post!"
    rescue
      flash[:notice] = "Fail to Like."
    end
    respond_with(@post, location: request.referer)
  end

  def destroy
    p "DDDDDDDD"
    p params
    p @post
    p current_user.post_likes

    begin
      post_like = current_user.post_likes.find_by_post_id(@post.id)
      post_like.destroy and flash[:notice] = "Unlike this post!"
    rescue
      flash[:notice] = "Fail to Unlike."
    end
    respond_with(@post, location: request.referer)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

end
