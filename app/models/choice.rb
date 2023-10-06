class Choice < ApplicationRecord

  belongs_to :question

  # Validations
  validates_presence_of :name
  validates :name, uniqueness: { scope: :question_id }

  validate :validate_choice_count

  private

  def validate_choice_count
    if question.choices.size > 4
      errors.add(:base, "Question cannot have more than 4 choices")
    end
  end

end
