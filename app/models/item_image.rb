class ItemImage < ApplicationRecord
  belongs_to :item

  validates :image, presence: true, uniqueness: {scope: :item_id}

  mount_uploader :image, ImageUploader
end
