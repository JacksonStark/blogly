require 'rails_helper'

RSpec.describe "Users", type: :request do
    let(:valid_attributes) {
        {email: 'john@example.com', password: 'test_password', password_confirmation: 'test_password'} 
    }

    let(:invalid_attributes) {
        {email: 'john@example.com', password: 'test_password', password_confirmation: 'unmatching_test_password'} 
    }

    describe "GET /new" do
        it "renders a successful response" do
        get new_user_url
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
        end
    end

    describe "POST /create" do
        context "with valid parameters" do
            it "creates a new user" do
                expect {
                    post users_url, params: { user: valid_attributes }
                }.to change(User, :count).by(1)
            end

            it "redirects to articles#index" do
                post users_url, params: { user: valid_attributes }
                expect(response).to redirect_to(articles_url)
            end
        end

        context "with invalid password confirmation" do
            it "does not create a new user" do
                expect {
                    post users_url, params: { user: invalid_attributes }
                }.to change(User, :count).by(0)
            end

            it "renders an unsuccessful response" do
                post users_url, params: { user: invalid_attributes }
                expect(response).to_not be_successful
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end
end
