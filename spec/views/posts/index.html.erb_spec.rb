require 'rails_helper'

RSpec.describe "posts/index", type: :view do

  let(:user) { User.create(email: "#{rand(50000)}@example.com", password: '123456')}
  let(:blog) { Blog.create(title: 'test-post-blog', desc: 'test-desc', user_id: user.id)}

  before(:each) do
    sign_in user
    assign(:posts, [
      Post.create!(
        :user_id => user.id,
        :blog_id => blog.id,
        :title => "Title",
        :body => "MyText",
        :published => true
      ),
      Post.create!(
        :user_id => user.id,
        :blog_id => blog.id,
        :title => "Title",
        :body => "MyText",
        :published => false
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => true.to_s, :count => 1
    assert_select "tr>td", :text => false.to_s, :count => 1
  end
end
