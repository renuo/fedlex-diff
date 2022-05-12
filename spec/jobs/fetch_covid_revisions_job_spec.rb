# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchCovidRevisionsJob, type: :job do
  let(:job) { described_class.new }
  let(:perform) { job.perform_now }

  describe '#perform' do
    it 'performs SPARQL request' do
      expect(job.perform).not_to eq(nil)
    end

    it 'saves new laws' do
      perform
      Law.first.destroy
      expect{ job.perform }.to change{ Law.count }.by(1)
    end

    it 'saves new revisions' do
      perform
      Revision.first.destroy
      expect{ job.perform }.to change{ Revision.count }.by(1)
    end

    it 'does not save the same law twice' do
      expect{ job.perform }.to change{ Law.count }.by(0)
    end

    it 'does not save the same revision twice' do
      expect{ job.perform }.to change{ Revision.count }.by(0)
    end
  end
end
