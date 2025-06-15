class City < ApplicationRecord
  has_many :users
  validates :city_name, :zip_code, uniqueness: true, presence: true
end
