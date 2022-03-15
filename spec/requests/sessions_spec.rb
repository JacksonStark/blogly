require 'rails_helper'

RSpec.describe "Sessions", type: :request do
    let(:valid_user) { create :user_with_all_attributes }

    describe "GET /login" do
        it "renders a successful response" do
            get login_url
            expect(response).to be_successful
            expect(response).to have_http_status(:ok)
            expect(response).to render_template("sessions/new")
        end
    end

    describe "POST /login" do
        context "with valid credentials" do
            it 'logs the user in' do
                post login_url, params: { user: { email: valid_user.email, password: valid_user.password } }
                expect(response).to have_http_status(:found)
                expect(response).to redirect_to(root_path)
                expect(flash[:notice]).to match("Signed in.")
            end
        end

        context "with invalid credentials" do
            it 'does not log the user in' do
                post login_url, params: { user: { email: valid_user.email, password: 'wrong password' } }
                expect(response).to_not be_successful
                expect(response).to have_http_status(:unprocessable_entity)
                expect(flash[:alert]).to match("Incorrect email or password.")
            end
        end
    end

    describe "DELETE /logout" do
        it 'logs the user out' do
            delete logout_url, params: { user: { email: valid_user.email, password: valid_user.password } }
            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(root_path)
            expect(flash[:notice]).to match("Signed out.")
        end
    end
end
