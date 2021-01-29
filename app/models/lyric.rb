class Lyric < ApplicationRecord
  validates :word, presence: true
  belongs_to :user
end
