require "rails_helper"

RSpec.describe PasswordMailer, type: :mailer do
    before(:all) do
        @user = create :user_with_all_attributes
    end

    describe "reset" do
        let(:mail) { PasswordMailer.with(user: @user).reset }

        it "renders the headers" do
            expect(mail.subject).to eq("Reset")
            expect(mail.to).to eq([@user.email])
            expect(mail.from).to eq(["jacksonstark77@hotmail.com"])
        end

        it "renders the body" do
            expect(mail.body.encoded).to include("Someone requested a reset of your password.")
        end
    end
end
