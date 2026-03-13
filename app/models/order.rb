class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum status: { pending: 0, paid: 1, processing: 2, completed: 3, cancelled: 4 }
  enum delivery_type: { pickup: 0, delivery: 1 }

  validates :total_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Считаем общую сумму
  def calculate_total
    self.total_price = order_items.sum { |item| item.price * item.quantity }
  end
end