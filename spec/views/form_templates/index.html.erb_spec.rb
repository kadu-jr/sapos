require 'rails_helper'

RSpec.describe "form_templates/index", type: :view do
  before(:each) do
    assign(:form_templates, [
      FormTemplate.create!(),
      FormTemplate.create!()
    ])
  end

  it "renders a list of form_templates" do
    render
  end
end
