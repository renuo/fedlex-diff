# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchCovidRevisionsJob, type: :job do
  let(:job) { described_class.new }

  let(:perform) do
    VCR.use_cassette('fetch_covid_revisions_job/perform_job') do
      job.perform_now
    end
  end

  describe '#perform' do
    it 'performs SPARQL request' do
      VCR.use_cassette('fetch_covid_revisions_job/basic_request') do
        expect(perform).not_to eq(nil)
      end
    end
  end
end
