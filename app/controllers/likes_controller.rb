class LikesController < ApplicationController
    before_action :authenticate_user!
    before_action :require_login
    before_action :find_post
    before_action :find_like, only: [:destroy] 
    # def create
    #     @post = Post.find(params[:post_id])
        
    #     if current_user
    #       if current_user.likes?(@post)
    #         flash[:notice] = "You've already liked this post."
    #       else
    #         current_user.like(@post)
    #         flash[:success] = "You've liked the post."
    #       end
    #     else
    #       flash[:alert] = "You must be logged in to like a post."
    #     end
      
    #     redirect_to posts_path(@post)
    # end
    def create
        if already_liked?
            flash[:notice] = "you can't like more than once"
        else
            @post.likes.create(user_id: current_user.id)
        end
        redirect_to post_path(@post)
    end

    def destroy
        if !(already_liked?)
            flash[:notice] = "can not unlike"
        else
            @like.destroy
        end
        redirect_to post_path(@post)
    end

    def find_post
        @post = Post.find_by(id: params[:id])
    end

    def already_liked?
        Like.where(user_id: current_user.id, post_id:params[:post_id]).exists?
    end

    def find_like
        @like = @post.likes.find(params[:id])
    end

end
