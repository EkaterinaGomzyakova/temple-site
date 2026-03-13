class Product < ApplicationRecord
  belongs_to :product_category
  belongs_to :created_by, class_name: "User"

  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }

  def in_stock?
    stock_quantity > 0
  end
end