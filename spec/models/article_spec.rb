require 'rails_helper'

RSpec.describe Article, type: :model do
    let(:article) {
        Article.new(
            title: "Test title",
            body: "Test body",
            image_url: 'www.test.com/test.jpg'
        )
    }

    it "is valid with all parameters" do
        expect(article).to be_valid
    end

    it "is valid with only required parameters" do
        article.body = nil
        article.image_url = nil
        expect(article).to be_valid
    end

    it "is invalid without required parameters" do
        article.title = nil
        expect(article).to_not be_valid
    end
end
