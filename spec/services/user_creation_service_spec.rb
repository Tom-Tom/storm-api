require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe UserCreationService do
  context 'When creates user' do
    let(:user) { create(:user) }
    it 'raises error with wrong params' do
      params = { first_name: 'toto' }
      expect { described_class.new(params) }.to raise_error(ArgumentError)
    end

    it 'raises error if email already exists' do
      user
      params = { first_name: 'Firstname',
                 last_name: 'LastName',
                 email: user.email }
      service = described_class.new(ActionController::Parameters.new(params))
      expect { service.create_with_hubspot_link }.to raise_error(ArgumentError)
    end

    it 'creates a user and create a worker' do
      params = { first_name: 'Firstname',
                 last_name: 'LastName',
                 email: Faker::Internet.unique.email }
      service = described_class.new(ActionController::Parameters.new(params))
      expect { service.create_with_hubspot_link }.to change(User, :count).by(1)
                                                                         .and change(HubspotCreationWorker.jobs, :size).by(1) # rubocop:disable Metrics/LineLength
    end
  end
end
