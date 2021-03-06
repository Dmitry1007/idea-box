class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    # @user = User.find(params[:id])
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash.now[:errors] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end