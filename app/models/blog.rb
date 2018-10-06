class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :posts

  validates :title, presence: true
  validates :user_id, presence: true

  scope :by_friendly_id, -> (id) { find_by_slug(id) }

  scope :by_user, -> (user_id) { where(user_id: user_id).order(:title) }
end
