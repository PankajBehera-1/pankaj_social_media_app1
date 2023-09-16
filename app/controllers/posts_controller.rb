
class PostsController < ApplicationController
    before_action :authenticate_user!, only: :index
    before_action :find_post, only: [:like]
  
    def index
      @posts = Post.all
    end
  
   
    def show
      @post = Post.find(params[:id])
      @comments = @post.comments.includes(:user)
    end

  
    def new
      @post = current_user.posts.build
    end
  
    def create
      @post = current_user.posts.build(post_params)
      
      if @post.save
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new
      end
    end
  
    def edit
        @post = current_user.posts.find_by_id(params[:id])
      
        if @post.nil?
          flash[:error] = "Post not found"
          redirect_to root_path
        end
    end
      
  
    def update
      @post = current_user.posts.find(params[:id])
      if @post.update(post_params)
        redirect_to @post, notice: 'Post was successfully updated.'
      else
        render 'edit'
      end
    end
  
    def destroy
      @post = current_user.posts.find(params[:id])
      @post.destroy
      redirect_to posts_path, notice: 'Post was successfully deleted.'
    end
  
    private
  
    def post_params
      params.require(:post).permit(:content, :image, :video, :avatar)
  
    end

    def like
      @post = Post.find(params[:id])
      current_user.liked_posts << @post unless current_user.liked_posts.include?(@post)
      redirect_to @post
    end
    

  private

  def find_post
    @post = Post.find(params[:id])
  end


  def store
    # upload image to cloudinary
    @image = Cloudinary::Uploader.upload(params[:media])
    # create a new post object and save to db
    @post = Post.new({:content => params[:content], :text => params[:text], :author => params[:author],  :media => @image['secure_url']})
    @post.save
    redirect_to('/')
end

end
  


  