# frozen_string_literal: true

FactoryBot.define do
  factory :revision do
    date_document { Faker::Date.backward(days: 20).to_s }
    date_applicability { Faker::Date.in_date_period }
    language_tag { 'de' }
    file_uri { 'MyString' }
    legislative_text { Faker::Lorem.paragraphs(number: 4) }
  end
end
