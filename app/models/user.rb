class User < ApplicationRecord
    has_secure_password
    before_save :downcase_email
    after_create :create_profile
    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
    has_one :profile

    private

    def downcase_email
        self.email = email.downcase
    end

    def create_profile
        Profile.create({user_id: self.id})
    end
end