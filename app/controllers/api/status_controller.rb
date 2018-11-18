module Api
  class StatusController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def index
      render json: {
        data: {
          name: 'storm-api',
          message: 'Up and running',
          healthy: 1
        }
      }, status: 200
    end
  end
end
