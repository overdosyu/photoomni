module PostsHelper
  def review_object(post_id)
    if @post_review = current_user.post_reviews.find_by_post_id(post_id)
        @post_review
    else
        current_user.post_reviews.new
    end
  end

  def can_be_reviewed?(post)
    if current_user.nil? ||
       current_user.id == post.user.id ||
       current_user.id != post.topic.user.id ||
       !post.photo.exists?
      false
    else
      true
    end
  end

  def review_rating(post)
    post.review ? post.review.rating : 0
  end

  def can_be_liked?(post)
    if current_user.nil? ||
       current_user.id == post.user.id
      false
    else
      true
    end
  end

  def like?(post)
    if current_user.post_likes.find_by_post_id(post.id)
      true
    else
      false
    end
  end

  def like_count(post)
    post.likes.count
  end
end
