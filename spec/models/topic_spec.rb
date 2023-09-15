# spec/models/topic_spec.rb

require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      topic = FactoryBot.build(:topic)
      expect(topic).to be_valid
    end

    it 'is not valid without a title' do
      topic = FactoryBot.build(:topic, title: nil)
      expect(topic).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many posts' do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq(:has_many)
    end
  end

  # Add more test cases as needed for your specific model's behavior.
end
