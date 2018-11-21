require 'rails_helper'

describe Api::UsersController do
  before do
    attach_headers
    sub_hubapi
  end

  it 'lists all users stored in Hubspot' do
    get :list_hubspot_users
    json = JSON.parse(response.body)
    expect(response).to be_success
    expect(json).to have_key('data')
  end

  def attach_headers
    key = Rails.application.secrets[:very_small_auth]
    request.env['HTTP_VERY_SMALL_AUTH'] = key
  end
  
  def sub_hubapi
    stub_request(:get, /https:\/\/api\.hubapi\.com*/).
        to_return(status: 200, body: { contacts: [] }.to_json, headers: {})
  end
end
