class Quiz < ApplicationRecord
  belongs_to :organization
  has_many :questions, dependent: :destroy
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags, allow_destroy: true

end
