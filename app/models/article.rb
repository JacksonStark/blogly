class Article < ApplicationRecord
    validates :title, presence: true
    paginates_per 15

    before_save :sanitize_body, if: -> { self.body_changed? }
    before_save :set_slug, if: -> { self.title_changed? }

    def to_param
        return nil unless persisted?
        [id, slug].join('-')
    end

    def set_slug
        self.slug = self.title.parameterize
    end

    def sanitize_body
        self.body = Sanitize.fragment(self.body, Sanitize::Config::RELAXED)
    end
end