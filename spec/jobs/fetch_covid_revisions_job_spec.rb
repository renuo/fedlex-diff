# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe FetchCovidRevisionsJob, type: :job do
  describe 'Sidekiq worker' do
    it 'enqueues job' do
      ActiveJob::Base.queue_adapter = :test
      expect do
        described_class.perform_later
      end.to have_enqueued_job(described_class)
    end

    it 'performs job' do
      VCR.use_cassette('fetch_covid_revisions_job/perform_job') do
        expect(FetchCovidRevisionsJob.perform_now).not_to eq(nil)
      end
    end
  end
end
