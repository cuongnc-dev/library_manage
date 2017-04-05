module ApplicationHelper
  def is_active controller
    params[:controller] == controller ? "active" : nil
  end

  def home_title_limit_book title
    title.truncate Settings.home_title_limit_book unless !title
  end

  def title_limit_book title
    title.truncate Settings.title_limit_book unless !title
  end

  def name_limit_book name
    name.truncate Settings.name_limit_book unless !name
  end

  def name_limit_publisher name
    name.truncate Settings.name_limit_publisher unless !name
  end

  def name_limit name
    name.truncate Settings.name_limit unless !name
  end

  def home_description_limit description
    description.truncate Settings.home_description_limit unless !description
  end

  def description_limit description
    description.truncate Settings.description_limit unless !description
  end

  def address_limit address
    address.truncate Settings.address_limit unless !address
  end

  def info_description_limit description
    description.truncate Settings.info_description_limit unless !description
  end

  def col_number counter
    counter + Settings.one
  end

  def calc_column_menu object
    (object.size - Settings.one) / Settings.ten + Settings.one
  end
end
