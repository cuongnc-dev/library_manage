class LikesController < ApplicationController
  before_action :load_like, only: :destroy

  def create
    @like = Like.new like_params
    respond_to do |format|
      if @like.save
        @book = Book.find_by id: @like.book_id
        @likes = @book.likes
        @total_like = @likes.present? ? @likes.size : 0
        format.json {render json: {like_status: :true, like_id: @like.id,
          total_like: @total_like}}
      else
        format.json {render json: {like_status: :false}}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @like.destroy
        @book = Book.find_by id: @like.book_id
        @likes = @book.likes
        @total_like = @likes.present? ? @likes.size : 0
        format.json {render json: {like_status: :true,
          total_like: @total_like}}
      else
        format.json {render json: {like_status: :false}}
      end
    end
  end

  private

  def like_params
    params.require(:like).permit :book_id, :user_id
  end

  def load_like
    @like = Like.find_by id: params[:id]
    return if @like
  end
end
