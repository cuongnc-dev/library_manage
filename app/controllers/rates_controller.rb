class RatesController < ApplicationController
  before_action :load_rate, only: :update

  def create
    @rate = Rate.new rate_params
    respond_to do |format|
      if @rate.save
        load_current_rate @rate.book_id
        format.json {render json: {rating_status: :true, rate_id: @rate.id,
          current_rating: @current_rating, avg_rating: @avg_rating,
          rates_size: @rates_size}}
      else
        format.json {render json: {rating_status: :false}}
      end
    end
  end

  def update
    respond_to do |format|
      if @rate.update_attributes rate_params
        load_current_rate @rate.book_id
        format.json {render json: {rating_status: :true, rate_id: @rate.id,
          current_rating: @current_rating, avg_rating: @avg_rating,
          rates_size: @rates_size}}
      else
        format.json {render json: {rating_status: :false}}
      end
    end
  end

  private

  def rate_params
    params.require(:rate).permit :rates, :book_id, :user_id
  end

  def load_rate
    @rate = Rate.find_by id: params[:id]
    return if @rate
  end

  def load_current_rate book_id
    @book = Book.find_by id: book_id
    @rates = @book.rates
    @rating = current_user.rates.find_by book_id: book_id
    @current_rating = @rating.nil? ? Settings.zero : @rating.rates
    @avg_rating = @rates.average(:rates)
    @rates_size = @rates.size
  end
end
