class User < ApplicationRecord
  has_secure_password
  has_many :gossips
  has_one_attached :avatar
  before_save { self.email = email.downcase }
  validates :email,
  presence: true,
  uniqueness: true,
  format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Entrez une adresse email valide" }
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :password_confirmation, presence: true, if: -> { new_record? || !password.nil? }
end
