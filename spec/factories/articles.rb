FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence(word_count: rand(3..8)) }
    body { Faker::Lorem.paragraph(sentence_count: rand(5..15)) }
    author_name { Faker::Name.name }
  end

  factory :article_with_comments, parent: :article do
    transient do
      comments_count { rand(1..5) }
    end

    after(:create) do |article, evaluator|
      create_list(:comment, evaluator.comments_count, article: article)
    end
  end
end
