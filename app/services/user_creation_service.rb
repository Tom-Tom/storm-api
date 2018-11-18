class UserCreationService
  attr_accessor :user
  
  def initialize(params)
    raise ArgumentError, 'Wrong params' unless ready_to_create?(params)
    @user = User.create(params)
    raise ArgumentError, @user.errors.full_messages unless @user.valid?
    
    # TODO: run worker for Hubspot
  end
  
  private
  
  def ready_to_create?(params)
    required_fields = %w[first_name last_name email]
    (required_fields & params.keys.map(&:to_s)).count == required_fields.count
  end
end