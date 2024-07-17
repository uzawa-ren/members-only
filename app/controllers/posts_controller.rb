class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = Post.all
  end

  # def show
  #   @post = Post.find(params[:id])
  # end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post[:user_id] = current_user[:id]

    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to posts_path
    else
      flash.now[:error] = "Could not be saved. Please correct the errors."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
