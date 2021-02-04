class Comment < ApplicationRecord
  belongs_to :lyric
  belongs_to :user
  has_many :notifications, dependent: :destroy
end
