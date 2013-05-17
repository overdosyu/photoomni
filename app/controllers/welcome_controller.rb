class WelcomeController < ApplicationController
  def index
    @posts = Post.all.select {|p| p.photo.present? }
  end
end
