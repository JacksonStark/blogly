require 'rails_helper'

RSpec.describe "/articles", type: :request do
    let(:valid_attributes) {
        {title: 'Test title', description: 'Test description', body: 'Test body', image_url: 'www.test.com/test.jpg'} 
    }

    let(:invalid_attributes) {
        {invalid_field: 'Test invalid field', another_invalid_field: 'Test invalid field'}
    }

    before(:all) do
        valid_user = create :user_with_all_attributes
        login_user(valid_user)
    end

    describe "GET /index" do
        it "renders a successful response" do
            create :article_with_all_attributes
            get articles_url
            expect(response).to be_successful
            expect(response).to have_http_status(:ok)
        end
    end

    describe "GET /show" do
        it "renders a successful response" do
            article = create :article_with_all_attributes
            get article_url(article)
            expect(response).to be_successful
            expect(response).to have_http_status(:ok)
        end

        it "renders an unsuccessful response" do
            get "/articles/invalid_id"
            expect(response).to_not be_successful
            expect(response).to_not have_http_status(:not_found)
            expect(flash[:notice]).to match("Article not found.")
            expect(response).to redirect_to(articles_url)
        end
    end

    describe "GET /new" do
        it "renders a successful response" do
            get new_article_url
            expect(response).to be_successful
            expect(response).to have_http_status(:ok)
        end
    end

    describe "GET /edit" do
        it "renders a successful response" do
            article = create :article_with_all_attributes
            get edit_article_url(article)
            expect(response).to be_successful
            expect(response).to have_http_status(:ok)
        end
    end

    describe "POST /create" do
        context "with valid parameters" do
            it "creates a new Article" do
                expect {
                    post articles_url, params: { article: valid_attributes }
                }.to change(Article, :count).by(1)
            end

            it "redirects to the created article" do
                post articles_url, params: { article: valid_attributes }
                expect(response).to redirect_to(article_url(Article.last))
            end
        end

        context "with invalid parameters" do
            it "does not create a new Article" do
                expect {
                    post articles_url, params: { article: invalid_attributes }
                }.to change(Article, :count).by(0)
            end

            it "renders an unsuccessful response" do
                post articles_url, params: { article: invalid_attributes }
                expect(response).to_not be_successful
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end

    describe "PATCH /update" do
        context "with valid parameters" do
            let(:new_attributes) {
                {title: 'New test title', description: 'New test description', body: 'New test body', image_url: 'www.test.com/updated_test.jpg'}
            }

            it "updates the requested article" do
                article = create :article_with_all_attributes
                patch article_url(article), params: { article: new_attributes }
                article.reload
                expect(article[:title]).to eq(new_attributes[:title])
                expect(article[:image_url]).to eq(new_attributes[:image_url])
            end

            it "redirects to the article" do
                article = create :article_with_all_attributes
                patch article_url(article), params: { article: new_attributes }
                article.reload
                expect(response).to redirect_to(article_url(article))
            end
        end

        context "with invalid parameters" do
            it "renders an unsuccessful response" do
                article = create :article_with_all_attributes
                patch article_url(article), params: { article: invalid_attributes }
                expect(response).to_not be_successful
                expect(response).to have_http_status(:found)
            end
        end
    end

  describe "DELETE /destroy" do
    it "destroys the requested article" do
        article = create :article_with_all_attributes
        expect {
            delete article_url(article)
        }.to change(Article, :count).by(-1)
        expect(response).to have_http_status(:found)
    end

    it "redirects to the articles list" do
        article = create :article_with_all_attributes
        delete article_url(article)
        expect(response).to redirect_to(articles_url)
        expect(response).to have_http_status(:found)
    end
  end
end
