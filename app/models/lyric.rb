class Lyric < ApplicationRecord
  validates :word, presence: true
  belongs_to :user
  has_many :comments
end
