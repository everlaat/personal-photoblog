class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts
  # accepts_nested_attributes_for :posts, allow_destroy: true
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
end
