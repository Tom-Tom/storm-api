Hubspot.configure(hapikey: Rails.application.secrets.dig(:hubspot, :hapikey))

# Hubspot.configure(
#   client_id: Rails.application.secrets.dig(:hubspot, :client_id),
#   client_secret: Rails.application.secrets.dig(:hubspot, :client_secret),
#   redirect_uri: Rails.application.secrets.dig(:hubspot, :redirect_uri)
# )