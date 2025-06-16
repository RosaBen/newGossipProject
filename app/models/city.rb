class City < ApplicationRecord
  has_many :users
  has_many :gossips, through: :users
  validates :city_name, :zip_code, uniqueness: true, presence: true
end
