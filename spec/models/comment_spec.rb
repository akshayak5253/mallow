# spec/models/comment_spec.rb

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      comment = FactoryBot.build(:comment)
      expect(comment).to be_valid
    end

    it 'is not valid without content' do
      comment = FactoryBot.build(:comment, content: nil)
      expect(comment).not_to be_valid
    end

    it 'is not valid without a user' do
      comment = FactoryBot.build(:comment, user: nil)
      expect(comment).not_to be_valid
    end

    it 'is not valid without a post' do
      comment = FactoryBot.build(:comment, post: nil)
      expect(comment).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  # Add more test cases as needed for your specific model's behavior.
end
