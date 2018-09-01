require 'rails_helper'

RSpec.describe "form_templates/new", type: :view do
  before(:each) do
    assign(:form_template, FormTemplate.new())
  end

  it "renders new form_template form" do
    render

    assert_select "form[action=?][method=?]", form_templates_path, "post" do
    end
  end
end
