require 'rails_helper'

RSpec.describe "Users", type: :request do
    let(:valid_attributes) {
        {email: 'john@example.com', password: 'test_password', password_confirmation: 'test_password'} 
    }

    let(:invalid_attributes) {
        {email: 'john@example.com', password: 'test_password', password_confirmation: 'unmatching_test_password'} 
    }

    describe "GET /register" do
        it "renders a successful response" do
        get register_url
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
        expect(response).to render_template("users/new")
        end
    end

    describe "POST /register" do
        context "with valid parameters" do
            it "creates a new user" do
                expect {
                    post register_url, params: { user: valid_attributes }
                }.to change(User, :count).by(1)
            end

            it "redirects to articles#index" do
                post register_url, params: { user: valid_attributes }
                expect(response).to redirect_to(root_path)
            end
        end

        context "with invalid password confirmation" do
            it "does not create a new user" do
                expect {
                    post register_url, params: { user: invalid_attributes }
                }.to change(User, :count).by(0)
            end

            it "renders an unsuccessful response" do
                post register_url, params: { user: invalid_attributes }
                expect(response).to_not be_successful
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end
end
