class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :very_small_auth

  private

  def very_small_auth
    very_small_auth = Rails.application.secrets[:very_small_auth]
    return if request.headers['HTTP_VERY_SMALL_AUTH'] == very_small_auth
    render json: {
      data: {
        name: 'storm-api',
        message: 'Wrong auth'
      }
    }, status: 403
  end
end
