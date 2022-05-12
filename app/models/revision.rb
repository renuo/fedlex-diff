# frozen_string_literal: true

class Revision < ApplicationRecord
  belongs_to :law

  validates :date_applicability, :language_tag, :file_uri, :legislative_text, presence: true
end
