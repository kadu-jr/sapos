require 'rails_helper'

RSpec.describe "FormTemplates", type: :request do
  describe "GET /form_templates" do
    it "works! (now write some real specs)" do
      get form_templates_path
      expect(response).to have_http_status(200)
    end
  end
end
