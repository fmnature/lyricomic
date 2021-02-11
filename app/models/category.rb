class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'ユーザー' },
    { id: 3, name: 'アーティスト' },
    { id: 4, name: 'キャラクター' },
    { id: 5, name: '軍師' },
    { id: 6, name: '研究者' },
    { id: 7, name: 'コメディアン'},
    { id: 8, name: '作家' },
    { id: 9, name: '実業家' },
    { id: 10, name: '哲学者' },
    { id: 11, name: 'その他' }
  ]
 
   include ActiveHash::Associations
   has_many :users
 
end