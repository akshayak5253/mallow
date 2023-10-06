class Question < ApplicationRecord
  belongs_to :quiz
  has_many :choices, dependent: :destroy
  belongs_to :user
  has_many :questions_users_read_statuses
  has_many :readers, through: :questions_users_read_statuses, source: :user
  def marked_as_read?(user)
    readers.include?(user)
  end
  def mark_as_read(user)
    questions_users_read_statuses.find_or_create_by(user: user).update(read: true)
  end
end
