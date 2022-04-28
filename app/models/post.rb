class Post < ApplicationRecord
    belongs_to :user
    has_many :comments
    validates :content, {presence: true, length: {maximum: 140}}
    validates :user_id, {presence: true}

    def user
    return User.find_by(id: self.user_id)
    end
end
