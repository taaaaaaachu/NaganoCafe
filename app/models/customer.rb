class Customer < ApplicationRecord
  has_many :items, through: :cart_items
  has_many :cart_items
  has_many :orders
  has_many :addresses,  dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
