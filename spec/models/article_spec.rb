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
end
