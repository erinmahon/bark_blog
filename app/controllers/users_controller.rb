class UsersController < ApplicationController
  before_action :authenticate_user, only: [:edit, :update, :destroy]
  def index
    @users = User.all
  end
  def new
  	@user = User.new
  end
  def edit
    @user = current_user
  end
  def show
  	@user = User.find(params[:id])
  end
  def create
  	@user = User.new(params.require(:user).permit( :fname, :lname, :email, :password, :password_confirmation))
  	if @user.save
      session[:user_id] = @user.id
  		redirect_to @user, notice: "New account created!"
  	else
  		render :new
  	end
  end
  def update
  end
  def destroy
  end
end
