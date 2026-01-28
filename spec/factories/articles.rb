FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence(word_count: rand(3..8)) }
    body { Faker::Lorem.paragraph(sentence_count: rand(5..15)) }
    author_name { Faker::Name.name }
  end
end
