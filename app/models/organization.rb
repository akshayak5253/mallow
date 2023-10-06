class Organization < ApplicationRecord
  has_many :quizzes, dependent: :destroy
  belongs_to :created_user, class_name: 'User', foreign_key: 'user_id'
  has_one_attached :icon
  validates :icon, blob: { content_type: %w[image/png image/jpg image/jpeg], size_range: 1..(2.megabytes) }
end
