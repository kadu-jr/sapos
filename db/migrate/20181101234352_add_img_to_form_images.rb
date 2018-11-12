class AddImgToFormImages < ActiveRecord::Migration[5.2]
  def change
    add_column :form_images, :img, :text
  end
end
