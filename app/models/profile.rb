class Profile < ApplicationRecord
    belongs_to :user

    def full_name
        return "#{self.first_name} #{self.last_name}"
    end

end
