FactoryBot.define do
    factory :profile do
        factory :profile_with_all_attributes do
            first_name { Faker::Name.first_name }
            last_name { Faker::Name.last_name }
            bio { Faker::Restaurant.description }
            image_url { Faker::LoremFlickr.image }
        end
    end
end
