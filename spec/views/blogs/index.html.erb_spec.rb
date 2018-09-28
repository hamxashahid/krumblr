require 'rails_helper'

RSpec.describe "blogs/index", type: :view do
  let(:user) { User.create(email: "#{rand(50000)}@example.com", password: '123456')}

  before(:each) do
    sign_in user
    assign(:blogs, [
      Blog.create!(
        :user_id => user.id,
        :title => "Title",
        :desc => "MyText"
      ),
      Blog.create!(
        :user_id => user.id,
        :title => "Title",
        :desc => "MyText"
      )
    ])
  end

  it "renders a list of blogs" do
    render
    assert_select "a", href: "/blogs/title/posts", :count => 2
    assert_select "p", :text => "MyText".to_s, :count => 2
  end
end
