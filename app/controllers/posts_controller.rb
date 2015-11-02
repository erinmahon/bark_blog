class PostsController < ApplicationController
  before_action  :authenticate_user, except: [:index, :show]
  def index
    @posts = Post.all
  end
  def new
    @post = Post.new
  end
  def edit
  end
  def show
  	@post = Post.find(params[:id])
  end
  def create
    @post = Post.new(params.require(:post).permit(:body).merge(user: current_user))
    if @post.save
	  redirect_to user_path(User.find(session[:user_id]))
	else
	  render :new
	end
  end
  def destroy
  	@post = Post.find(params[:id])
  	@post.destroy
  	redirect_to root_path, alert: "Bark deleted."
  end
  def update
  end
end