class UserCommentRating < ApplicationRecord
  belongs_to :user
  belongs_to :comment
  has_many :user_comment_ratings
  has_many :users, through: :user_comment_ratings
end
