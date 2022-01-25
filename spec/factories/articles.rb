FactoryBot.define do
    factory :article do
        factory :article_with_all_attributes do
            title { "Test title" }
            description { "Test description" }
            body { "Test body" }
            image_url { 'www.test.com/test.jpg' }
        end

        factory :article_with_no_title do
            description { "Test description" }
            body { "Test body" }
            image_url { 'www.test.com/test.jpg' }
        end

        factory :article_with_only_title do
            title { "Test title" }
        end

        factory :article_with_script_in_body do
            title { "Test title" }
            body { "<script></script>" }
        end

    end
end