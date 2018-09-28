require "rails_helper"

RSpec.describe BlogsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/blogs").to route_to("blogs#index")
    end

    it "routes to #manage" do
      expect(:get => "/blogs/manage").to route_to("blogs#manage")
    end

    it "routes to #posts" do
      expect(:get => "/blogs/1/posts").to route_to("blogs#posts", id: "1")
    end

    it "routes to #post_details" do
      expect(:get => "/blogs/1/post_details/1").to route_to("blogs#post_details", id: "1", post_id: '1')
    end

    it "routes to #new" do
      expect(:get => "/blogs/new").to route_to("blogs#new")
    end

    it "routes to #show" do
      expect(:get => "/blogs/1").to route_to("blogs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/blogs/1/edit").to route_to("blogs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/blogs").to route_to("blogs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/blogs/1").to route_to("blogs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/blogs/1").to route_to("blogs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/blogs/1").to route_to("blogs#destroy", :id => "1")
    end

  end
end
