FactoryBot.define do
    factory :user do
        factory :user_with_all_attributes do
            email { "john@example.com" }
            password { "test_password" }
            password_confirmation { "test_password" }
        end

        factory :user_with_no_email do
            password { "test_password" }
            password_confirmation { "test_password" }
        end

        factory :user_with_uppercase_email do
            email { "JOHN@EXAMPLE.COM" }
            password { "test_password" }
            password_confirmation { "test_password" }
        end

        factory :user_with_invalid_password_confirmation do
            email { "john@example.com" }
            password { "test_password" }
            password_confirmation { "unmatching_test_password" }
        end
    end
end