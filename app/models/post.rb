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
end
