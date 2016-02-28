class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new

  end

  def create
    user = User.find_by(email: params[:password_reset][:email].downcase)
    if user
      user.password_reset
      user.send_reset_email
      flash[:info] = 'Email sent with password reset instructions'
      redirect_to root_path
    else
      flash.now[:danger] = 'Email address not found'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      log_in @user
      flash[:success] = 'Your password has been reset'
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    redirect_to root_url unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
  end

  def check_expiration
    if @user.reset_expired?
      flash[:danger] = 'Your password reset email has exceeded expiration time'
      redirect_to new_password_reset_path
    end
  end
end
