class Admin::SubcategoriesController < ApplicationController
  before_action :verify_admin
  before_action :load_subcategory, only: [:show, :edit, :destroy, :update]
  before_action :load_category, except: :destroy
  before_action :load_notification

  layout "admin"

  def show
  end

  def new
    @subcategory = Subcategory.new
  end

  def index
    case
    when params[:key]
      case
      when params[:find_by] == Category.name
        @subcategories = Subcategory.list_subcategory_by_category_name(params[:key]).
          list_subcategory_order_name.
          paginate page: params[:page], per_page: Settings.per_page
      else
        @subcategories = Subcategory.search_subcategory_by_name(params[:key]).
          list_subcategory_order_name.
          paginate page: params[:page], per_page: Settings.per_page
      end
    else
      @subcategories = Subcategory.list_subcategory_order_name.
        paginate page: params[:page], per_page: Settings.per_page
    end
  end

  def create
    @subcategory = Subcategory.new subcategory_params
    if @subcategory.save
      flash[:success] = t "subcategories.add_subcategory_success"
      redirect_to admin_subcategories_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @subcategory.update_attributes subcategory_params
      flash[:success] = t "subcategories.update_success"
      redirect_to admin_subcategories_url
    else
      render :edit
    end
  end

  def destroy
    if @subcategory.destroy
      flash[:success] = t "subcategories.delete_success"
    else
      flash[:danger] = t "subcategories.delete_fail"
    end
    redirect_to admin_subcategories_url
  end

  private

  def load_subcategory
    @subcategory = Subcategory.find_by id: params[:id]
    return if @subcategory
    flash[:warning] = t "subcategories.subcategory_not_found"
    redirect_to admin_subcategories_url
  end

  def load_category
    @categories = Category.list_category_order_name
  end

  def subcategory_params
    params.require(:subcategory).permit :category_id, :name
  end
end
