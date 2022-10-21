require 'rails_helper'

RSpec.describe Profile, type: :model do
    it "is associated with a user" do
        user = create :user_with_all_attributes
        profile = user.profile

        expect(profile).to be_valid
    end
end
