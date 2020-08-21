class User < ApplicationRecord
  has_one :street
  has_many :items
  has_many :messages, through: :users_messages
  has_many :messages
  has_many :users_messages
  has_many :credits, through: :users_credits
  has_many :credits
  has_many :users_credits

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :surname, presence: true
  validates :surname_kana, presence: true
  validates :firstname, presence: true
  validates :firstname_kana, presence: true
  validates :Birthday, presence: true
  validates :nick_name, presence: true, uniqueness: true       
  validates :email, presence: true, uniqueness: true

end
