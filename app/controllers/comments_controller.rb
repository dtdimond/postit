class CommentsController < ApplicationController
  before_action :set_post_and_comment, only: [:edit, :update, :vote]
  before_action :require_user

  def create
    @post = Post.find_by(slug: params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.user = current_user

    if params[:body].nil?
      @post.comments.delete(@comment)
      @comment.errors.add(:body, "cannot be blank.")
    end

    if @comment.save 
      flash[:notice] = "Comment was successfully posted."
      redirect_to post_path(@post)
    else
      #flash[:error] = "Comment cannot be blank." if params[:body].nil?
      render "posts/show" 
    end
  end

  def edit
    require_ownership(@comment.user.id)
  end

  def update
    require_ownership(@comment.user.id)

    if @comment.update(params.require(:comment).permit(:body, :user_id))
      flash[:notice] = "Comment updated."
      redirect_to post_path(@post) 
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(voteable: @comment, user: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if !@vote.valid?
          flash[:error] = "You can only vote once. All votes are final!"
        end
        redirect_to :back
      end
      format.js do
      end
    end

  end

  def set_post_and_comment
    @post = Post.find_by(slug: params[:post_id])
    @comment = @post.comments.find_by(slug: params[:id])
  end
end
