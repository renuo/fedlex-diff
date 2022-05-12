# frozen_string_literal: true

FactoryBot.define do
  factory :law do
    sr_number { '818.102' }
    title { Faker::Lorem.sentence }
    title_alternative { Faker::Lorem.sentence(word_count: 3) }
    language { 'de' }
  end
end
