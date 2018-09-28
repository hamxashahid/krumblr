class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :posts

  validates :title, presence: true
  validates :user_id, presence: true
end
