module Api
  class WebhookCallbacksController < ApplicationController
    skip_before_action :verify_authenticity_token

    def hubspot_callback
      data = params["json"]
      puts data
      render status: 200, json: {}.to_json
    end
  end
end
