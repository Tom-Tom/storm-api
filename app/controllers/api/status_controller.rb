module Api
  class StatusController < BaseController
    skip_before_action :very_small_auth

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
