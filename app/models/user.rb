class User < ApplicationRecord
   validates :name, presence: true, length: { maximum: 30 }
   validates :email, presence: true, length: { maximum: 100 },
     format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
     
     
  
   #validates :password, presence: true, length: { minimum: 6 }
  
  with_options if: :password do |user|
  user.validates :password, 
    on: :create,
    presence: { message: "パスワードを入力して下さい" },
    length: { minimum: 6 },
    confirmation: { allow_blank: true } 
  user.validates :password, 
    on: :update,
    presence: { message: "新しいパスワードを入力して下さい" },
    length: { minimum: 6 },
    confirmation: { allow_blank: true }
end
  
   before_save { email.downcase! }
   
   has_secure_password
   
   mount_uploader :image, ImageUploader
   
   has_many :blogs
   has_many :favorites, dependent: :destroy
   has_many :favorite_blogs, through: :favorites, source: :blog
end
