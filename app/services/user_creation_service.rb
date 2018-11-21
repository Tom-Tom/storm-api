# Service to create a user
# It calls Hubspot API through Sidkiq worker
# Possible runtime errors:
#   - ArgumentError
class UserCreationService
  attr_accessor :user

  # Do NOT forget to rescue the following errors where it is called
  # Possible errors:
  #   - ArgumentError
  def initialize(params)
    @params = params
    @email = params[:email]
    raise ArgumentError, 'Wrong params' unless ready_to_create?
  end

  # Do NOT forget to rescue the following errors where it is called
  # Possible errors:
  #   - ArgumentError
  def create_with_hubspot_link
    @user = User.create(sanitized_params)
    raise ArgumentError, @user.errors.full_messages unless @user.valid?

    valid_params = sanitized_params
                   .merge(hs_content_membership_notes: 'Some text')
                   .to_h
    HubspotCreationWorker.perform_async(@email, valid_params)
  end

  private

  def sanitized_params
    @params.permit(:firstname, :lastname, :email)
  end

  def ready_to_create?
    required_fields = User.column_names
                          .reject { |n| n.in?(%w[id created_at updated_at]) }
    (required_fields & @params.keys.map(&:to_s)).count == required_fields.count
  end
end
