require "rails_helper"

RSpec.describe FormTemplatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/form_templates").to route_to("form_templates#index")
    end

    it "routes to #new" do
      expect(:get => "/form_templates/new").to route_to("form_templates#new")
    end

    it "routes to #show" do
      expect(:get => "/form_templates/1").to route_to("form_templates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/form_templates/1/edit").to route_to("form_templates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/form_templates").to route_to("form_templates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/form_templates/1").to route_to("form_templates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/form_templates/1").to route_to("form_templates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/form_templates/1").to route_to("form_templates#destroy", :id => "1")
    end

  end
end
