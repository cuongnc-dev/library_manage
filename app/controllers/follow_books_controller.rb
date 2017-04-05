class FollowBooksController < ApplicationController
  before_action :load_follow_book, only: :destroy

  def create
    @follow_book = FollowBook.new follow_book_params
    respond_to do |format|
      if @follow_book.save
        format.json {render json: {follow_status: :true,
          follow_id: @follow_book.id}}
      else
        format.json {render json: {follow_status: :false}}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @follow_book.destroy
        format.json {render json: {follow_status: :true}}
      else
        format.json {render json: {follow_status: :false}}
      end
    end
  end

  private

  def follow_book_params
    params.require(:follow_book).permit :user_id, :book_id
  end

  def load_follow_book
    @follow_book = FollowBook.find_by id: params[:id]
    return if @follow_book
  end
end
