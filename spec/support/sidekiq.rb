RSpec::Sidekiq.configure do |config|
    config.warn_when_jobs_not_processed_by_sidekiq = false
    ActiveJob::Base.queue_adapter = :test
  end
  
  Sidekiq::Testing.inline!