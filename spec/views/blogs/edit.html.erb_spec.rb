require 'rails_helper'

RSpec.describe "blogs/edit", type: :view do

  let(:user) { User.create(email: "#{rand(50000)}@example.com", password: '123456')}

  before(:each) do
    sign_in user
    @blog = assign(:blog, Blog.create!(
      :user_id => user.id,
      :title => "MyString",
      :desc => "MyText"
    ))

  end

  it "renders the edit blog form" do
    render

    assert_select "form[action=?][method=?]", blog_path(@blog), "post" do

      assert_select "input[name=?]", "blog[title]"

      assert_select "textarea[name=?]", "blog[desc]"
    end
  end
end
