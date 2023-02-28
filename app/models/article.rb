class Article < ApplicationRecord
    extend Services::StateMachine

    # State machine DSL
    state_machine do
        state :draft, initial: true
        state :pending_review
        state :published

        event :review do
            transitions from: [:draft], to: :pending_review
        end

        event :publish do
            transitions from: [:draft, :pending_review], to: :published
        end
    
        event :unpublish do
            transitions from: :published, to: :draft
        end
    end

    validates :title, presence: true
    paginates_per 15
    before_save :sanitize_body, if: -> { self.body_changed? }
    before_save :set_slug, if: -> { self.title_changed? }

    def to_param
        return persisted? ? [id, slug].join('-') : nil
    end

    def set_slug
        self.slug = self.title.parameterize
    end

    def sanitize_body
        self.body = Sanitize.fragment(self.body, Sanitize::Config::RELAXED)
    end
end