# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Revision, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:date_applicability) }
    it { is_expected.to validate_presence_of(:language_tag) }
    it { is_expected.to validate_presence_of(:file_uri) }
    it { is_expected.to validate_presence_of(:legislative_text) }
  end
end
