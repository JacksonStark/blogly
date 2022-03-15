FactoryBot.define do
    factory :article do
        factory :article_with_all_attributes do
            title { Faker::Book.title }
            description { Faker::Restaurant.description }
            body { Faker::Lorem.paragraph }
            image_url { Faker::LoremFlickr.image }
        end

        factory :article_with_no_title do
            description { Faker::Restaurant.description }
            body { Faker::Lorem.paragraph }
            image_url { Faker::LoremFlickr.image }
        end

        factory :article_with_only_title do
            title { Faker::Book.title }
        end

        factory :article_with_script_in_body do
            title { Faker::Book.title }
            body { "<script></script>" }
        end

    end
end