class Form < ApplicationRecord
belongs_to :query
belongs_to :template, class_name: "FormTemplate"
has_and_belongs_to_many  :form_image

validates_presence_of :nome
validates :query, :presence => true
validates :template, :presence => true

def to_label
  "#{self.nome}"
end

end
