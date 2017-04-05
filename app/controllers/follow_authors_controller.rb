class FollowAuthorsController < ApplicationController
  before_action :load_follow_author, only: :destroy

  def create
    @follow_author = FollowAuthor.new follow_author_params
    respond_to do |format|
      if @follow_author.save
        @author = Author.find_by id: @follow_author.author_id
        @follow_authors = @author.follow_authors
        @total_follow = @follow_authors.present? ? @follow_authors.size : 0
        format.json {render json: {follow_status: :true,
          follow_id: @follow_author.id, total_follow: @total_follow}}
      else
        format.json {render json: {follow_status: :false}}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @follow_author.destroy
        @author = Author.find_by id: @follow_author.author_id
        @follow_authors = @author.follow_authors
        @total_follow = @follow_authors.present? ? @follow_authors.size : 0
        format.json {render json: {follow_status: :true,
          total_follow: @total_follow}}
      else
        format.json {render json: {follow_status: :false}}
      end
    end
  end

  private

  def follow_author_params
    params.require(:follow_author).permit :user_id, :author_id
  end

  def load_follow_author
    @follow_author = FollowAuthor.find_by id: params[:id]
    return if @follow_author
    redirect_to root_url
  end
end
