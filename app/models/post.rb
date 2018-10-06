class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  belongs_to :blog

  validates :title, presence: true
  validates :user_id, presence: true
  validates :blog_id, presence: true

  acts_as_commontable dependent: :destroy
  acts_as_taggable

  scope :published, -> { where(published: true) }

  scope :by_friendly_id, -> (id) { find_by_slug(id) }

  scope :by_user, -> (user_id) { where(user_id: user_id).order(:title) }

  scope :search, -> (text, blog_id) {
    query = <<~SQL
        SELECT posts.* 
        FROM posts 
        INNER JOIN taggings PT ON PT.taggable_id = posts.id AND PT.taggable_type = 'Post' 
        AND PT.tag_id IN (SELECT tags.id FROM tags WHERE LOWER(tags.name) LIKE '#{text}' ESCAPE '!') 
        WHERE posts.blog_id = '#{blog_id}' AND posts.published = 1 
        UNION SELECT posts.* FROM posts WHERE title LIKE '%#{text}%' OR body LIKE '%#{text}%'
    SQL
    find_by_sql(query)
  }
end
