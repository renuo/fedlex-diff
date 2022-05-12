# frozen_string_literal: true

class Law < ApplicationRecord
  has_many :revisions, dependent: :destroy

  validates :sr_number, :title, :language, presence: true
end
