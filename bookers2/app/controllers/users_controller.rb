class UsersController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @users = User.all
    @new_book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @new_book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to user_path(current_user.id)
    end
    if @user.update(user_params)
      flash[:notice] = "You have updated your user info successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
