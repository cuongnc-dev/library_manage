class AddImageToPublishers < ActiveRecord::Migration[5.0]
  def change
    add_column :publishers, :image, :string
  end
end
