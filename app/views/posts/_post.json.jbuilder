json.extract! post, :id, :user_id, :blog_id, :title, :body, :published, :created_at, :updated_at
json.url post_url(post, format: :json)
