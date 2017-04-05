class UsersController < ApplicationController
  before_action :load_user, only: :update
  before_action :load_menu
  before_action :load_notification
  before_action :store_location

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    respond_to do |format|
      if @user.save
        @user.send_activation_email
        flash.now[:info] = t "check_email"
        format.html {render :new}
        format.js
      else
        format.html {render :new}
        format.js
      end
    end
  end

  def update
    if @user.update_attributes user_params
      flash.now[:success] = t "users.update_success"
    else
      flash.now[:warning] = t "users.update_fail"
    end
    render :show
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation,
      :phone, :address, :avatar
  end
end
