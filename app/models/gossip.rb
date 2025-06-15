class Gossip < ApplicationRecord
  belongs_to :user
  has_one_attached :media
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 3, maximum: 1000 }
end
