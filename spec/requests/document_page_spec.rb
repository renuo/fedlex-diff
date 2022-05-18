# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DocumentPages', type: :request do
  describe 'GET /index' do
    let(:law) { create(:law, sr_number: '1234', title: 'law example') }
    let(:revision1) { create(:revision, date_applicability: '2022-02-02', law_id: law.id) }
    let(:revision2) { create(:revision, date_applicability: '2022-02-02', law_id: law.id) }

    let(:params) do
      {
        sr_number: 101,
        language_tag: 'de'
      }
    end

    it 'raises an error without params' do
      expect { get document_page_url }.to raise_error(NoMethodError)
    end

    it 'return http success with correct params' do
      get '/document_page', params: { sr_number: '818.102', language_tag: 'de' }
      expect(response).to have_http_status(:success)
    end

    it 'returns http success with revisions in params' do
      law
      revision1
      revision2
      get '/document_page', params: { sr_number: law.sr_number, language_tag: 'de',
                                      revision: [
                                        revision1.date_applicability,
                                        revision2.date_applicability
                                      ] }
      expect(response).to have_http_status(:success)
    end
  end
end
