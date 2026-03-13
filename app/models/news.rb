class News < ApplicationRecord
  # Автор новости
  belongs_to :created_by, class_name: "User"

  # Контент с возможностью rich text и вставки изображений
  has_rich_text :content

  # Галерея изображений новости
  has_many_attached :images

  # Валидации
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  # Сортировка по позиции
  default_scope { order(position: :asc) }

  # Статус публикации
  scope :published, -> { where(is_published: true) }
end