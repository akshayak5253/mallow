class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :questions
  has_many :ratings
  has_many :questions_users_read_statuses
  has_many :read_questions, -> { where("questions_users_read_statuses.read": true) }, through: :questions_users_read_statuses, source: :question, class_name: "Question"
  has_many :unread_questions, -> { where("questions_users_read_statuses.read": false) }, through: :questions_users_read_statuses, source: :question, class_name: "Question"
end
