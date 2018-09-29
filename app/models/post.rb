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
  scope :contains_text, -> (text) { where('title LIKE ? OR body LIKE ?', "%#{text}%", "%#{text}%")}
end
