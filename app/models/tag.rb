class Tag < ApplicationRecord
  has_many :taggings
  has_many :lyrics, through: :taggings
  validates :name, uniqueness: true
end
