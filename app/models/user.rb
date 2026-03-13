class User < ApplicationRecord
  # Devise
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  # Профиль
  has_one :profile, dependent: :destroy

  # Клубы
  has_many :club_memberships, dependent: :destroy
  has_many :clubs, through: :club_memberships

  # Заказы
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  # Администрируемые клубы
  has_many :administered_clubs,
           class_name: "Club",
           foreign_key: "admin_user_id"

  # Контент
  has_many :created_events, class_name: "Event", foreign_key: "created_by_id"
  has_many :created_news, class_name: "News", foreign_key: "created_by_id"
  has_many :created_products, class_name: "Product", foreign_key: "created_by_id"

  enum role: { user: 0, admin: 1 }

  validates :email, presence: true, uniqueness: true

  after_create :create_profile_from_name

  private

  def create_profile_from_name
    Profile.create!(user: self, name: self.name) if self.name.present?
  end
end