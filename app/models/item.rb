class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images, allow_destroy: true
  has_many :messages
  # user連携時にコメントを外すこと
  # belongs_to :sell_user, class_name: "User", optional: true
  # belongs_to :buy_user, class_name: "User", optional: true
  belongs_to_active_hash :phase
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_area, class_name: "Prefecture"
  belongs_to_active_hash :delivery_to_pay
  belongs_to_active_hash :delivery_day
  belongs_to :category
  belongs_to :user

  validates :name, presence: true
  validates :price, presence: true
  validates :item_images, presence: true
end
