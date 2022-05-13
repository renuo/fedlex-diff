# frozen_string_literal: true

if defined? Sidekiq
  schedule_file = 'config/schedule.yml'

  if File.exist?(schedule_file) && Sidekiq.server?
    errors = Sidekiq::Cron::Job.load_from_hash!(YAML.load_file(schedule_file))
    Rails.logger.error "Errors loading scheduled jobs: #{errors}" if errors.any?
  end
end
