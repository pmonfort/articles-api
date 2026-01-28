FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph(sentence_count: rand(2..5)) }
    author_name { Faker::Name.name }
    association :article
  end
end
