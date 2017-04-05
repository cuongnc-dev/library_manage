class RequestsController < ApplicationController
  before_action :load_menu
  before_action :load_book, only: [:new, :edit]
  before_action :load_notification
  before_action :load_request, except: [:new, :create]

  def index
    @requests = Request.list_request_by_user current_user.id
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new request_params
    if @request.save
      flash.now[:success] = t "requests.request_success"
      admins = User.search_user_by_role_admin
      create_request_notification @request, admins
      RequestNotificationJob.perform_now @request, admins
      @request.email_new_request @request
      respond_to do |format|
        format.js
      end
    else
      @book = request_params[:book_id]
      render :new
    end

  end

  def edit
  end

  def update
    if @request.update_attributes request_params
      flash.now[:success] = t "requests.update_success"
      respond_to do |format|
        format.js
      end
    else
      @book = request_params[:book_id]
      render :edit
    end
  end

  def destroy
    @book = Book.find_by id: @request.book_id
    if @request.destroy
      flash.now[:success] = t "requests.delete_success"
    else
      flash.now[:danger] = t "requests.delete_fail"
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def request_params
    params.require(:request).permit :user_id, :book_id, :content, :start_day,
      :end_day, :status
  end

  def load_request
    @request = Request.find_by id: params[:id]
    return if @request
  end

  def load_book
    @book = params[:book]
  end

  def create_request_notification request, admins
    content = t "request_borrow_book"
    admins.each do |admin|
      Notification.create user_id: admin.id, request_id: request.id,
        book_id: request.book_id, type_notification: Settings.two
    end
  end
end
