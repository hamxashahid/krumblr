require 'rails_helper'

RSpec.describe "posts/show", type: :view do

  let(:user) { User.create(email: "#{rand(50000)}@example.com", password: '123456')}
  let(:blog) { Blog.create(title: 'test-post-blog', desc: 'test-desc', user_id: user.id)}
  before(:each) do
    sign_in user
    @post = assign(:post, Post.create!(
      :user_id => user.id,
      :blog_id => blog.id,
      :title => "Title",
      :body => "MyText",
      :published => true
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/true/)
  end
end
