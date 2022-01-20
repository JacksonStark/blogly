require 'rails_helper'

RSpec.describe Article, type: :model do
    it "is valid with all parameters" do
        article = create :article_with_all_attributes
        expect(article).to be_valid
    end

    it "is valid with only required parameters" do
        article = create :article_with_only_title
        expect(article).to be_valid
    end

    it "is invalid without title" do
        article = build :article_with_no_title
        expect(article).to_not be_valid
    end

    it "creates slug when created" do
        article = create :article_with_all_attributes
        expect(article.slug).to match("test-title")
    end

    it "updates slug when updated" do
        article = create :article_with_all_attributes
        article.update(title: 'Updated test title')
        expect(article.slug).to match("updated-test-title")
    end

    it 'joins id with slug as to_param' do
        article = create :article_with_all_attributes
        id_joined_with_slug = article.id.to_s+'-'+article.slug

        expect(article.to_param).to eq id_joined_with_slug
    end
end