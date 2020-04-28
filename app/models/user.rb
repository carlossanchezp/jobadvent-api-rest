class User < ApplicationRecord
  # Secutity
  has_secure_password
  
  # Relations
  has_many :products, dependent: :destroy

  # Validations
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/
  validates :password_digest, presence: true
end
