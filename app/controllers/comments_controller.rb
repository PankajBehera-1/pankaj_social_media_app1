class CommentsController < ApplicationController
    before_action :authenticate_user!
  


    def index
      @comments = Comment.all
    end
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user
  
      if @comment.save
        redirect_to @post, notice: 'Comment was successfully created.'
      else
        redirect_to @post, alert: 'Failed to create comment.'
      end
    end
  
    def destroy
      @comment = Comment.find_by(id: params[:id])
  
      if @comment
        if current_user == @comment.user
          @comment.destroy
          flash[:success] = 'Comment deleted successfully.'
        else
          flash[:alert] = "You can only delete your own comments."
        end
      else
        flash[:alert] = "Comment not found."
      end
  
      redirect_to @post # Redirect to an appropriate path
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
end
