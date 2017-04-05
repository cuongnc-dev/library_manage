class Admin::PublishersController < ApplicationController
  before_action :verify_admin
  before_action :load_publisher, only: [:show, :edit, :destroy, :update]
  skip_before_filter :verify_authenticity_token, only: [:create, :update]
  before_action :load_notification

  layout "admin"

  def show
  end

  def new
    @publisher = Publisher.new
  end

  def index
    case
    when params[:key]
      case
      when params[:find_by] == "Name"
        @publishers = Publisher.search_publisher_by_name(params[:key]).
          list_publisher_newest.paginate page: params[:page],
          per_page: Settings.per_page
      else params[:find_by] == "Email"
        @publishers = Publisher.search_publisher_by_email(params[:key]).
          list_publisher_newest.paginate page: params[:page],
          per_page: Settings.per_page
      end
    else
      @publishers = Publisher.list_publisher_newest.paginate page: params[:page],
        per_page: Settings.per_page
    end
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def create
    @publisher = Publisher.new publisher_params
    if @publisher.save
      flash[:success] = t "publishers.add_publisher_success"
      redirect_to admin_publishers_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @publisher.update_attributes publisher_params
      flash[:success] = t "publishers.update_success"
      redirect_to admin_publishers_url
    else
      render :edit
    end
  end

  def destroy
    if @publisher.destroy
      flash[:success] = t "publishers.delete_success"
    else
      flash[:danger] = t "publishers.delete_fail"
    end
    redirect_to admin_publishers_url
  end

  private

  def load_publisher
    @publisher = Publisher.find_by id: params[:id]
    return if @publisher
    flash[:warning] = t "publishers.publisher_not_found"
    redirect_to admin_publishers_url
  end

  def publisher_params
    params.require(:publisher).permit :name, :email, :phone, :address, :image
  end
end
