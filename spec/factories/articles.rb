FactoryBot.define do
    factory :article do
        factory :article_with_all_attributes do
            title { "Test title" }
            body { "Test body" }
            image_url { 'www.test.com/test.jpg' }
        end

        factory :article_with_no_title do
            body { "Test body" }
            image_url { 'www.test.com/test.jpg' }
        end

        factory :article_with_only_title do
            title { "Test title" }
        end
    end
end