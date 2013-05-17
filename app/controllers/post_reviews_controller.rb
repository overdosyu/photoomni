class PostReviewsController < ApplicationController
  before_filter :find_post, only: [:create, :update]
  before_filter :check_for_authorization, only: [:create, :update]

  def create
    @post_review = PostReview.new(params[:post_review])
    @post_review.user_id = current_user.id
    @post_review.post_id = @post.id

    if @post_review.save
      flash[:notice] = "Your review has been saved."
    else
      flash[:error] = "Fail to save the review."
    end
    render :nothing => true
  end

  def update
    if @post.review.update_attributes(params[:post_review])
      flash[:notice] = "Your review has been updated."
    else
      flash[:error] = "Fail to update the review."
    end
    render :nothing => true
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def check_for_authorization
    if current_user.id == @post.user.id
      flash[:error] = "You cannot review your own post."
      redirect_to(:back)
    end

    if current_user.id != @post.topic.user.id
      flash[:error] = "You can ONLY review the posts under your topic."
      redirect_to(:back)
    end
  end

end
