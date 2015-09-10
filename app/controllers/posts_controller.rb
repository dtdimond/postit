class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
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
    require_ownership(@post.user.id)
  end

  def update
    require_ownership(@post.user.id)

    if @post.update(post_params)
      flash[:notice] = "Post was successfully updated."
      redirect_to posts_path
    else
      render :edit
    end
  end

  def vote
    vote = Vote.create(voteable: @post, user: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if !vote.valid?
          flash[:error] = "You can only vote once. All votes are final!"
        end
        redirect_to :back
      end
      format.js do
      end
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids:[])
  end

  def find_post
    @post = Post.find(params[:id]) 
  end
end
