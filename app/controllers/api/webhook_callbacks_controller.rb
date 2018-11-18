module Api
  class WebhookCallbacksController < BaseController
    skip_before_action :very_small_auth
    
    def hubspot_callback
      data = params["json"]
      puts data
      render status: 200, json: {}.to_json
    end
  end
end
