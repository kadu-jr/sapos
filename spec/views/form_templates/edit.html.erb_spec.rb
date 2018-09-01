require 'rails_helper'

RSpec.describe "form_templates/edit", type: :view do
  before(:each) do
    @form_template = assign(:form_template, FormTemplate.create!())
  end

  it "renders the edit form_template form" do
    render

    assert_select "form[action=?][method=?]", form_template_path(@form_template), "post" do
    end
  end
end
