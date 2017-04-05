class Admin::RequestsController < ApplicationController
  before_action :verify_admin
  before_action :load_request, only: [:show, :edit, :update]
  skip_before_filter :verify_authenticity_token, only: :update
  before_action :load_notification

  layout "admin"

  def show
  end

  def index
    case
    when params[:key] || params[:from_day] || params[:status]
      case
      when params[:find_by] == Settings.name
        @requests = Request.search_request_by_user(params[:key]).
          list_request_newest.paginate page: params[:page], per_page: Settings.per_page
      when params[:find_by] == Settings.title
        @requests = Request.search_request_by_book(params[:key]).
          list_request_newest.paginate page: params[:page], per_page: Settings.per_page
      when params[:find_by] == Settings.date
        from_day = DateTime.parse(params[:from_day]).strftime("%Y-%m-%d 00:00:00")
        to_day = DateTime.parse(params[:to_day]).
          strftime("%Y-%m-%d 00:00:00") if params[:to_day].present?
        case
        when params[:find_date_by] == Settings.char_zero
          @requests = Request.search_by_absolute_start_day(from_day).
            list_request_newest.paginate page: params[:page], per_page: Settings.per_page
        when params[:find_date_by] == Settings.char_one
          @requests = Request.search_by_relative_start_day(from_day, to_day).
            list_request_newest.paginate page: params[:page], per_page: Settings.per_page
        when params[:find_date_by] == Settings.char_two
          @requests = Request.search_by_absolute_end_day(from_day).list_request_newest.
            paginate page: params[:page], per_page: Settings.per_page
        when params[:find_date_by] == Settings.char_three
          @requests = Request.search_by_relative_end_day(from_day, to_day).
            list_request_newest.paginate page: params[:page], per_page: Settings.per_page
        else
          @requests = Request.search_by_start_end_day(from_day, to_day).
            list_request_newest.paginate page: params[:page], per_page: Settings.per_page
        end
      else
        @requests = Request.search_request_by_status(params[:status]).
          list_request_newest.paginate page: params[:page], per_page: Settings.per_page
      end
    else
      @requests = Request.list_request_newest.paginate page: params[:page],
        per_page: Settings.per_page
    end
  end

  def edit
  end

  def update
    if @request.update_attributes request_params
      flash[:success] = t "requests.update_success"
      if @request.accepted? || @request.rejected?
        RespondNotificationJob.perform_now @request
        @request.email_respond_request @request
      end
      if @request.borrowed? || @request.returned?
        @request.update_current_book @request.book_id, @request.borrowed?
      end
      redirect_to admin_requests_url
    else
      render :edit
    end
  end

  private

  def load_request
    @request = Request.find_by id: params[:id]
    return if @request
    redirect_to admin_requests_url
  end

  def request_params
    params.require(:request).permit :start_day, :end_day, :content, :status
  end

  def create_respond_notification request
    check = Notification.search_request_notification request.id, Settings.three
    Notification.create user_id: request.user_id, book_id: request.book_id,
      request_id: request.id, type_notification: Settings.three unless check.present?
  end
end
