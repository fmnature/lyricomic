class Lyric < ApplicationRecord
  validates :word, presence: true
  belongs_to :user
  has_many :comments
  has_many :likes
  has_one_attached :image

  validates :word, presence: true, unless: :was_attached?

  def was_attached?
    self.image.attached?
  end

  def self.search(search)
    if search != ""
      Lyric.where('word LIKE(?)', "%#{search}%")
    else
      Lyric.all
    end
  end
end
