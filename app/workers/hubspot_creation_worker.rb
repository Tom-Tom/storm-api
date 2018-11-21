class HubspotCreationWorker
  include Sidekiq::Worker

  def perform(email, params)
    # To avoid duplication error, user `createOrUpdate` instead of `create!`
    Hubspot::Contact.createOrUpdate(email, params)
  rescue Hubspot::RequestError
    # TODO: do something in case of failure..
  end
end
