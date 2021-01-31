class Lyric < ApplicationRecord
  validates :word, presence: true
  belongs_to :user
  has_many :comments
  has_one_attached :image

  def self.search(search)
    if search != ""
      Lyric.where('word LIKE(?)', "%#{search}%")
    else
      Lyric.all
    end
  end
end
