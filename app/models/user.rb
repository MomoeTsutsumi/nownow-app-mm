class User < ApplicationRecord

    has_secure_password
    
    has_many :posts, dependent: :destroy
    has_many :comments
    validates :name, {presence: true}
    validates :email, {presence: true, uniqueness: true}
    
def posts 
    return Post.where(user_id: self.id)
end


end
