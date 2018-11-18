# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

def require_ngrok
  require 'ngrok/tunnel'
  options = {
      addr: 3001,
      region: 'eu'
  }
  if File.file? '.ngrok'
    options[:config] = '.ngrok'
  elsif File.file? ENV['HOME'] + '/.ngrok'
    options[:config] = ENV['HOME'] + '/.ngrok'
  end
  options[:inspect] = ENV['NGROK_INSPECT'] if ENV['NGROK_INSPECT']
  puts '[NGROK] tunneling at ' + Ngrok::Tunnel.start(options)
  puts '[NGROK] tunneling at ' + Ngrok::Tunnel.ngrok_url_https

  # Directly set on Heroku for staging/prod
  Rails.application.secrets[:hubspot][:redirect_path] = Ngrok::Tunnel.ngrok_url_https + Rails.application.secrets.dig(:hubspot, :redirect_path)
  unless ENV['NGROK_INSPECT'] == 'false'
    puts '[NGROK] inspector web interface listening at http://127.0.0.1:4040'
  end
rescue Ngrok::FetchUrlError => e
  p e
end

require_ngrok unless %w[production staging].include?(ENV['RAILS_ENV'])