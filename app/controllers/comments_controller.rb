class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body).merge(user_id: 1))

    if @comment.save
      flash[:notice] = "Comment was successfully posted."
      redirect_to post_path(@post)
    else
      render "posts/show" 
    end
  end

end
