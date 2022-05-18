# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DocumentPages', type: :request do
  describe 'GET /index' do
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
  end
end
