class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar # если нужна аватарка через ActiveStorage

  validates :name, presence: true
end