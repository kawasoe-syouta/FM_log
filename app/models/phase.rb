class Phase < ActiveHash::Base
  self.data = [
      {id: 1, phase: '出品中'}, {id: 2, phase: '支払い待ち'}, {id: 3, phase: '発送待ち'},
      {id: 4, phase: '取引完了'}
  ]
end