class User < ApplicationRecord
  has_secure_password
  has_many :gossips
  has_many :comments, dependent: :destroy
  belongs_to :city
  has_one_attached :avatar
  has_many :likes, dependent: :destroy
  has_many :liked_gossips, through: :likes, source: :gossip
before_save :pseudo_downcase
before_save :email_downcase
  validates :email,
  presence: true,
  uniqueness: true,
  format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Entrez une adresse email valide" }
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :password_confirmation, presence: true, if: -> { new_record? || !password.nil? }
  validates :pseudo, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 20 }
  validates :bio, length: { maximum: 2000 }, allow_blank: true

  def pseudo_downcase
    self.pseudo = pseudo.downcase if pseudo.present?
  end

  def email_downcase
    self.email = email.downcase if email.present?
  end

  def self.find_userid_by_pseudo(pseudo)
    return nil if pseudo.nil? || pseudo.strip.empty?
    user = User.find_by("LOWER(pseudo) = ?", pseudo.downcase)
    user&.id
  end

  def self.find_by_email_or_pseudo(email_or_pseudo)
    where("LOWER(email) = ? OR LOWER(pseudo) = ?", email_or_pseudo, email_or_pseudo).first
  end
end
