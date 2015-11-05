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
      flash[:alert] =""
      if @user.errors.any? 
        @user.errors.full_messages.each do | error |
          flash[:alert] += error + " "
        end 
      end 
  		render :new
  	end
  end
  def update
  end
  def destroy
  end
  def search
    full_name = params[:search_name]
    name_parts = full_name.split(" ")
    search_results = []
    name_parts.each do |part|
      first_name_results = User.where(fname: part.capitalize)
      first_name_results.each do |result|
        if !search_results.include?(result)
          search_results.push(result)
        end
      end
      last_name_results = User.where(lname: part.capitalize)
      last_name_results.each do |result|
        if !search_results.include?(result)
          search_results.push(result)
        end
      end
    end

    if(search_results.length == 0)
      flash[:notice] = "No results found."
      redirect_to users_path
    elsif (search_results.length == 1)
      redirect_to user_path search_results.first
    else
      @users = search_results
    end
  end
end

