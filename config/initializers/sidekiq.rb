# frozen_string_literal: true

if defined? Sidekiq
  schedule_file = 'config/schedule.yml'

  if File.exist?(schedule_file) && Sidekiq.server?
    errors = Sidekiq::Cron::Job.load_from_hash!(YAML.load_file(schedule_file))
    Rails.logger.error "Errors loading scheduled jobs: #{errors}" if errors.any?
  end
end


Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV["REDIS_URL"],
    ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV["REDIS_URL"],
    ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
  }
end
