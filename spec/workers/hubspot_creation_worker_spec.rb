require 'rails_helper'
RSpec.describe HubspotCreationWorker, type: :worker do
  it 'calls Hubspot API' do
    email = "some@email.com"
    params = {firstname: 'toto'}
    stub_hubspot_calls(email, params)
    expect(Hubspot::Contact).to receive(:createOrUpdate).with(email, params).once
    described_class.new.perform(email, params)
  end
  
  def stub_hubspot_calls(email, params)
    fake_id = 12
    stub_request(:post, /https:\/\/api\.hubapi\.com\/contacts\/v1\/contact\/createOrUpdate\/email\/#{email}\?hapikey\=*/).
        with(
            body: { properties: properties_builder(params) }.to_json,
            headers: {
                'Content-Type'=>'application/json'
            }).
        to_return(status: 200, body: {'vid': fake_id}.to_json, headers: {})

    stub_request(:get, /https:\/\/api\.hubapi\.com\/contacts\/v1\/contact\/vid\/#{fake_id}\/profile\?hapikey=*/).
        to_return(status: 200, body: {}.to_json, headers: {})

  end
  
  def properties_builder(params)
    params.map{|key,val| {property: key, value: val}}
  end
end
