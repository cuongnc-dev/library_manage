class Admin::CategoriesController < ApplicationController
  before_action :verify_admin
  before_action :load_category, only: [:show, :edit, :destroy, :update]
  before_action :load_notification

  layout "admin"

  def show
  end

  def new
    @category = Category.new
  end

  def index
    if params[:key]
      @categories = Category.search_category_by_name(params[:key]).
        paginate page: params[:page], per_page: Settings.per_page
    else
      @categories = Category.list_category_order_name.paginate page: params[:page],
        per_page: Settings.per_page
    end
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash.now[:success] = t "categories.add_category_success"
      redirect_to admin_categories_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash.now[:success] = t "categories.update_success"
      redirect_to admin_categories_url
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash.now[:success] = t "categories.delete_success"
    else
      flash.now[:danger] = t "categories.delete_fail"
    end
    redirect_to admin_categories_url
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash.now[:warning] = t "categories.category_not_found"
    redirect_to admin_categories_url
  end

  def category_params
    params.require(:category).permit :name
  end
end
