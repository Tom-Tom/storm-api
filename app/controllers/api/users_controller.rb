module Api
  # Controller of user for API access
  class UsersController < BaseController
    def create
      service = UserCreationService.new(params[:user])
      service.create_with_hubspot_link
      res = { name: 'create-user',
              message: 'User created successfully' }
      render_json(200, res)
    rescue ArgumentError => err
      res = { name: 'create-user',
              message: err.message }
      render_json(400, res)
    end

    # No security, just here for test validation
    def list_hubspot_users
      res = Hubspot::Contact.all.map(&:properties)
      render_json(200, res)
    end

    private

    def render_json(status, data)
      render json: { data: data }, status: status
    end
  end
end
