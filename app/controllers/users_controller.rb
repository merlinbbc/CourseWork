class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  before_action :set_user, only: [:show,:update,:edit]

  def index
    @users = User.limit(10).order(rating: :desc)
    @tasks = Task.limit(10).order(mark: :desc)
  end

  def show

  end

  def edit

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Nickname was updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def set_user
    @user = User.find(params[:id]);
  end

  def user_params
    params.require(:user).permit(:nickname);
  end

end
