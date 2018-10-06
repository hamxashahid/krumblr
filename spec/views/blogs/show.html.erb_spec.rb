require 'rails_helper'

RSpec.describe "blogs/show", type: :view do
  let(:user) { User.create(email: "#{rand(50000)}@example.com", password: '123456')}

  before(:each) do
    @blog = assign(:blog, Blog.create!(
      :user_id => user.id,
      :title => "Title",
      :desc => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
