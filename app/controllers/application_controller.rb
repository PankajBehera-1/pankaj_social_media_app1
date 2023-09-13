class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        posts_path
    end


    def show
        @post = Post.find(params[:id])
        # Fetch any associated comments if needed
        @comments = @post.comments
    end
end
