# Post
class Post < ApplicationRecord
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  has_many :ratings, dependent:  :destroy
  has_one_attached :image
  belongs_to :user
  def average_rating
    return 0 if ratings.empty?

    ratings_average = ratings.average(:stars)
    ratings_average || 0  # If ratings_average is nil, return 0
  end
  has_many :posts_users_read_statuses
  has_many :readers, through: :posts_users_read_statuses, source: :user
  def marked_as_read?(user)
    readers.include?(user)
  end
  def mark_as_read(user)
    posts_users_read_statuses.find_or_create_by(user: user).update(read: true)
  end
end
