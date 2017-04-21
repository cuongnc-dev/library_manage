class Admin::BooksController < ApplicationController
  before_action :verify_admin
  before_action :load_book, only: [:show, :edit, :destroy, :update]
  before_action :load_author, exept: [:show, :destroy]
  before_action :load_category, exept: [:show, :destroy]
  before_action :load_publisher, exept: [:show, :destroy]
  before_action :load_notification
  skip_before_filter :verify_authenticity_token, only: [:create, :update]

  layout "admin"

  def show
  end

  def new
    @book = Book.new
  end

  def index
    case
    when params[:key]
      case
      when params[:find_by] == Book.name
        @books = Book.search_book_by_title(params[:key]).list_book_newest.
          paginate page: params[:page], per_page: Settings.per_page
      when params[:find_by] == Author.name
        @books = Book.search_book_by_author(params[:key]).list_book_newest.
          paginate page: params[:page], per_page: Settings.per_page
      when params[:find_by] == Subcategory.name
        @books = Book.search_book_by_subcategory(params[:key]).
          list_book_newest.paginate page: params[:page], per_page: Settings.per_page
      else
        @books = Book.search_book_by_publisher(params[:key]).
          list_book_newest.paginate page: params[:page], per_page: Settings.per_page
      end
    else
      @books = Book.list_book_newest.paginate page: params[:page],
        per_page: Settings.per_page
    end
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash.now[:success] = t "books.add_book_success"
      users_follow = User.list_users_follow_author @book.author_id
      create_book_notification @book, users_follow
      BookNotificationJob.perform_now @book, users_follow
      EmailBookJob.perform_now users_follow, @book if users_follow.present?
      redirect_to admin_books_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update_attributes book_params
      flash.now[:success] = t "books.update_success"
      redirect_to admin_books_url
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash.now[:success] = t "books.delete_success"
    else
      flash.now[:danger] = t "books.delete_fail"
    end
    redirect_to admin_books_url
  end

  private

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash.now[:warning] = t "books.book_not_found"
    redirect_to admin_books_url
  end

  def load_category
    @categories = Subcategory.list_subcategory_order_name
  end

  def load_author
    @authors = Author.list_author_order_name
  end

  def load_publisher
    @publishers = Publisher.list_publisher_order_name
  end

  def book_params
    params.require(:book).permit :title, :image, :description, :author_id,
      :subcategory_id, :publisher_id, :current, :page_number
  end

  def create_book_notification book, users_follow
    users_follow.each do |user_follow|
      Notification.create user_id: user_follow.id, book_id: book.id,
        type_notification: Settings.one
    end
  end
end
