class BooksController < ApplicationController
  before_action :load_book, only: :show
  before_action :load_user, only: :show
  before_action :load_menu
  before_action :load_notification
  before_action :store_location

  def index
    case
    when params[:key_word]
      case
      when params[:find_by] == Book.name
        @books = Book.search_book_by_title(params[:key_word]).list_book_newest.
          paginate page: params[:page], per_page: Settings.per_page
      when params[:find_by] == Author.name
        @books = Book.search_book_by_author(params[:key_word]).list_book_newest.
          paginate page: params[:page], per_page: Settings.per_page
      when params[:find_by] == Category.name
        @books = Book.search_book_by_category(params[:key_word]).
          list_book_newest.paginate page: params[:page], per_page: Settings.per_page
      when params[:find_by] == Subcategory.name
        @books = Book.search_book_by_subcategory(params[:key_word]).
          list_book_newest.paginate page: params[:page], per_page: Settings.per_page
      else
        @books = Book.search_book_by_publisher(params[:key_word]).
          list_book_newest.paginate page: params[:page], per_page: Settings.per_page
      end
    else
      @books = Book.list_book_newest.paginate page: params[:page],
        per_page: Settings.per_page
    end
  end

  def show
    @comment = Comment.new
    @comments = @book.comments.list_newest_comment
    @rate = Rate.new
    @rates = @book.rates
    @like = Like.new
    @likes = @book.likes
    @follow = FollowBook.new
    if logged_in?
      @rating = current_user.rates.find_by book_id: params[:id]
      @current_rating = @rating.nil? ? Settings.zero : @rating.rates
      @liked = current_user.likes.find_by book_id: params[:id]
      @following = current_user.follow_books.find_by book_id: params[:id]
      @request = current_user.requests.find_by book_id: params[:id]
    end
    @avg_rating = @rates.present? ? @rates.average(:rates) : Settings.zero
  end

  private

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    redirect_to books_url
  end

  def load_user
    if logged_in?
      @user = User.find_by id: current_user.id
      return if @user
      redirect_to root_url
    end
  end
end
