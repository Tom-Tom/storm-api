require 'rails_helper'

describe Api::StatusController do
  it 'has access to api status' do
    get :index
    expect(response).to be_success
  end
end
