class ItemImage < ApplicationRecord
  belongs_to :item

  # validates :image, presence: true, uniqueness: {scope: :item, case_sensitive: true}
  validates :image, presence: true

  mount_uploader :image, ImageUploader
end
