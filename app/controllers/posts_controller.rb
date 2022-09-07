class PostsController < ApplicationController
 
  def index
    
    # @posts = Post.last(2)
    # @posts =  Post.all.order('created_at DESC')
    @posts = Post.paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end

  before_action :authenticate_user!, except: %i[index show]
  def new
    @post = Post.new
  end

  # def htmlshow
  #   @post = Post.find_by(id: 3)
  #   render html: @post.content.html_safe
  # end
  
  def create
    @post = Post.new(post_params)
    @post.userName = current_user.email
    @post.user_email = current_user.email
    if @post.save

      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def show_by_user
    @posts = Post.where(userName: current_user.email).order('created_at DESC')
  end
  def top_rated_posts
    # @posts =  Post.where(ratingCount: Post.maximum(:ratingCount)).order('created_at DESC')
      postavg = Post.average(:total_rating)
      @posts = Post.where("total_rating > ?", postavg).order('created_at DESC')
  end
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  
  def rating 
    @post = Post.find(params[:id])
    @post.rating_count += 1
    @post.total_rating += params[:rating].to_i
    @post.save
    redirect_to @post
  end
  helper_method :rating
  private

  def post_params
    params.require(:post).permit(:title, :content, :rating_count, :total_rating)
  end
end
