class Comment < ApplicationRecord
  belongs_to :lyric
  belongs_to :user
end