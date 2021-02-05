class LyricsTag

  include ActiveModel::Model
  attr_accessor :word, :text, :name, :image, :user_id

  with_options presence: true do
    validates :word
    validates :user_id
  end

  def save
    tag = Tag.where(name: name).first_or_initialize
    tag.save
    lyric = Lyric.create(word: word, text: text, image: image, user_id: user_id)

    Tagging.create(lyric_id: lyric.id, tag_id: tag.id)
  end

end