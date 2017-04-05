class AuthorsController < ApplicationController
  before_action :load_author
  before_action :load_menu
  before_action :load_notification
  before_action :store_location

  def show
    @follow = FollowAuthor.new
    @follows = @author.follow_authors
    @current_follow = current_user.follow_authors.
      find_by author_id: params[:id] if logged_in?
    @books = Book.list_book_by_author(@author.id).list_book_newest
  end

  private

  def load_author
    @author = Author.find_by id: params[:id]
    return if @author
    redirect_to books_path
  end
end
