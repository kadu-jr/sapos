require 'rails_helper'

RSpec.describe "form_templates/show", type: :view do
  before(:each) do
    @form_template = assign(:form_template, FormTemplate.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
