class IndexTemplateImages < ActiveRecord::Migration[5.1]
  def change
    create_join_table :form_templates, :form_images do |t|
      # t.index [:form_id, :form_image_id]
      # t.index [:form_image_id, :form_id]
    end
  end
end
