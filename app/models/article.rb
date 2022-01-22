class Article < ApplicationRecord
    validates_presence_of :title
    paginates_per 15

    before_create do
        self.slug = self.title.parameterize 
    end

    before_update do
        self.slug = self.title.parameterize 
    end

    def to_param
        return nil unless persisted?
        [id, slug].join('-')
    end
end