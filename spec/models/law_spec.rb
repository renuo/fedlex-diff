# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Law, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:sr_number) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:language) }
  end
end
