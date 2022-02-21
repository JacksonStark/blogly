require 'rails_helper'

RSpec.describe User, type: :model do
    it "is valid with all parameters" do
        user = create :user_with_all_attributes
        expect(user).to be_valid
    end

    it "is invalid without email" do
        user = build :user_with_no_email
        expect(user).to_not be_valid
    end

    it "is invalid with invalid password confirmation" do
        user = build :user_with_invalid_password_confirmation
        expect(user).to_not be_valid
    end

    it "is invalid with non-unique email" do
        user1 = create :user_with_all_attributes
        user2 = build :user_with_all_attributes
        expect(user2).to_not be_valid
    end

    it "downcases email" do
        user = create :user_with_uppercase_email
        expect(user.email).to eq user.email.downcase
    end

end