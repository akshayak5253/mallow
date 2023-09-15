# spec/models/post_spec.rb

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      post = FactoryBot.build(:post)
      expect(post).to be_valid
    end

    it 'is not valid without a title' do
      post = FactoryBot.build(:post, title: nil)
      expect(post).not_to be_valid
    end

    it 'is not valid without content' do
      post = FactoryBot.build(:post, content: nil)
      expect(post).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a topic' do
      association = described_class.reflect_on_association(:topic)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
    end
  end

  # Add more test cases as needed for your specific model's behavior.
end
