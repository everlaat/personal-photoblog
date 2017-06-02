class PostsController < ApplicationController
  protect_from_forgery with: :exception

  def index
    @posts = Post.recent 25
    render layout: 'application'
  end

  private

  def post_params
    params.require(:author).permit(:email, :name)
  end
  
end
