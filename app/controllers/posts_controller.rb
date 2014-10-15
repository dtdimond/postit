class PostsController < ApplicationController
  before_action :find_post, only: [:show,:edit,:update]
  before_action :require_user, except: [:show, :index]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post was successfully submitted."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post was successfully updated."
      redirect_to posts_path
    else
      render :edit
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids:[])
  end

  def find_post
    @post = Post.find(params[:id]) 
  end
end
