class User < ApplicationRecord
  has_secure_password
  has_many :gossips
  has_one_attached :avatar
before_save :pseudo_downcase
before_save :email_downcase
  validates :email,
  presence: true,
  uniqueness: true,
  format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Entrez une adresse email valide" }
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :password_confirmation, presence: true, if: -> { new_record? || !password.nil? }

  def pseudo_downcase
    self.pseudo = pseudo.downcase if pseudo.present?
  end

  def email_downcase
    self.email = email.downcase if email.present?
  end
  def self.find_userid_by_pseudo(pseudo)
    user = User.find_by("LOWER(pseudo) = ?", pseudo.downcase)
    user&.id
  end
  # def self.find_userid_by_email(email)
  #   user = User.find_by("LOWER(email) = ?", email.downcase)
  #   user&.id
  # end

  # def self.find_user_by_pseudo(pseudo)
  #   User.find_by("LOWER(pseudo) = ?", pseudo.downcase)
  # end

  # def self.find_user_by_email(email)
  #   User.find_by("LOWER(email) = ?", email.downcase)
  # end
  # def self.find_user_by_id(id)
  #   User.find_by(id: id)
  # end

  # def self.find_user_by_pseudo_or_email(pseudo_or_email)
  #   user = User.find_by("LOWER(pseudo) = ? OR LOWER(email) = ?", pseudo_or_email.downcase, pseudo_or_email.downcase)
  #   user
  # end
end
