require 'rails_helper'


RSpec.describe "posts/new", type: :view do

  let(:user) { User.create(email: "#{rand(50000)}@example.com", password: '123456')}
  let(:blog) { Blog.create(title: 'test-post-blog', desc: 'test-desc', user_id: user.id)}

  before(:each) do
    sign_in user
    assign(:post, Post.new(
      :user_id => user.id,
      :blog_id => blog.id,
      :title => "MyString",
      :body => "MyText",
      :published => false
    ))
    @blogs = assign(:blogs, [blog])
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do

      assert_select "input[name=?]", "post[title]"

      assert_select "textarea[name=?]", "post[body]"

      assert_select "input[name=?]", "post[published]"
    end
  end
end
