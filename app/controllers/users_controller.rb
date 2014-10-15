class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, only: [:edit, :show]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You've successfully registered!"
      session[:user_id] = @user.id #Auto-login user on registration.
      redirect_to root_path 
    else
      render :new
    end
  end

  def edit
    require_ownership(@user.id)
  end

  def update
    require_ownership(@user.id)

    if @user.update(user_params)
      flash[:notice] = "You profile was updated."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
