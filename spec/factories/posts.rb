FactoryBot.define do
  factory :post do
    user_id 1
    blog_id 1
    title "MyString"
    body "MyText"
    published false
  end
end
