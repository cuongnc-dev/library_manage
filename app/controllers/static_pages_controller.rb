class StaticPagesController < ApplicationController
  before_action :load_menu

  def index
    @new_books = Book.list_book_newest_limit(Settings.five)
    @high_rating_books = Book.list_book_high_rating(Settings.five)
  end
end
