# Model
class Comment < ApplicationRecord
   belongs_to :post, counter_cache: true
  belongs_to :user
  has_many :user_comment_ratings
end
