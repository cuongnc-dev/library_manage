class Admin::UsersController < ApplicationController
  before_action :verify_admin
  before_action :load_user, only: [:show, :edit, :destroy, :update]
  skip_before_filter :verify_authenticity_token, only: [:create, :update]
  before_action :load_notification

  layout "admin"

  def show
  end

  def new
    @user = User.new
  end

  def index
    case
    when (params[:key] || params[:admin] || params[:user] ||
      params[:activated] || params[:not_activate])
      case
      when params[:find_by] == "Name"
        @users = User.search_user_by_name(params[:key]).list_user_newest.
          paginate page: params[:page], per_page: Settings.per_page
      when params[:find_by] == "Email"
        @users = User.search_user_by_email(params[:key]).list_user_newest.
          paginate page: params[:page], per_page: Settings.per_page
      when params[:find_by] == "Role" && params[:admin]
        @users = User.search_user_by_role_admin.list_user_newest.
          paginate page: params[:page], per_page: Settings.per_page
      when params[:find_by] == "Role" && params[:user]
        @users = User.search_user_by_role_user.list_user_newest.
          paginate page: params[:page], per_page: Settings.per_page
      when params[:find_by] == "Activate" && params[:activated]
        @users = User.search_user_by_activated.list_user_newest.
          paginate page: params[:page], per_page: Settings.per_page
      else
        @users = User.search_user_by_not_activate.list_user_newest.
          paginate page: params[:page], per_page: Settings.per_page
      end
    else
      @users = User.list_user_newest.paginate page: params[:page],
        per_page: Settings.per_page
    end
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "users.add_user_success"
      redirect_to admin_users_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.update_success"
      redirect_to admin_users_url
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:warning] = t "users.user_not_found"
    redirect_to admin_users_url
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation,
      :phone, :is_admin, :activated, :address, :avatar
  end
end
