require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { User.create(email: "#{rand(50000)}@example.com", password: '123456')}
  before(:each) do
    sign_in user
  end

  describe "GET /posts" do
    it "works! (now write some real specs)" do
      get posts_path
      expect(response).to have_http_status(:ok)
    end
  end
end
