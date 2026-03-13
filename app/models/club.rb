class Club < ApplicationRecord
  # Администратор клуба
  belongs_to :admin_user, class_name: "User"

  # Участники клуба
  has_many :club_memberships, dependent: :destroy
  has_many :members, through: :club_memberships, source: :user

  # Клубные события
  has_many :events, dependent: :destroy

  has_one_attached :image

  # Слаг и сортировка
  validates :name, presence: true
end
