require 'rails_helper'

RSpec.describe Lyric, type: :model do
  before do
    @lyric = FactoryBot.build(:lyric)
  end

  describe 'ユーザー新規登録' do
    it 'user_idとwordが存在すれば登録できること' do
      expect(@lyric).to be_valid
    end

    it 'wordが空では登録できないこと' do
      @lyric.word = ''
      @lyric.valid?
      expect(@lyric.errors.full_messages).to include("Word can't be blank")
    end
  end
end
