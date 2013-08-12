class WelcomeController < ApplicationController
  def index
    @posts = Post.recent_updated.select {|p| p.photo.present? }
  end
end
