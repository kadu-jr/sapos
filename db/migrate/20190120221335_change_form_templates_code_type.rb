class ChangeFormTemplatesCodeType < ActiveRecord::Migration[5.1]
  def up
    change_column :FormTemplate, :code, :text
  end
end
