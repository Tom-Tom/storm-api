require 'rails_helper'

RSpec.describe UserCreationService do
  context 'When creates user' do
    let (:user) { create(:user) }
    it 'raises error with wrong params' do
      params = { first_name: 'toto' }
      expect { described_class.new(params) }.to raise_error(ArgumentError)
    end

    it 'raises error if email already exists' do
      user
      params = { first_name: 'Firstname',
                 last_name: 'LastName',
                 email: user.email }
      expect { described_class.new(params) }.to raise_error(ArgumentError)
    end

    it 'creates a user' do
      params = { first_name: 'Firstname',
                 last_name: 'LastName',
                 email: Faker::Internet.unique.email }
      expect { described_class.new(params) }.not_to raise_error
    end
  end
end