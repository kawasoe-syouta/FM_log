class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :item_images
  has_many :messages
  belongs_to :sell_user, class_name: "User"
  belongs_to :buy_user, class_name: "User"
  belongs_to_active_hash :phase
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_to_pay
  belongs_to :category

  validates :name, presence: true
  validates :price, presence: true
  validates :delivery_days, presence: true
end
