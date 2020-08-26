class Street < ApplicationRecord
  belongs_to :user, optional: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  validates :postal_code, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
end
