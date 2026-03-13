class Event < ApplicationRecord
  # Связи
  belongs_to :club, optional: true                 # Клуб для клубных событий
  belongs_to :created_by, class_name: "User"      # Пользователь-автор события

  has_many :event_tags, dependent: :destroy       # Таблица связей с тегами
  has_many :tags, through: :event_tags            # Теги для культурных событий

  # Описание с поддержкой rich text и изображений внутри текста
  has_rich_text :description

  # Изображения
  has_one_attached :cover_image                    # Обложка события
  has_many_attached :images                        # Галерея изображений события

  # Enum для типа события
  enum event_type: { club_event: 0, culture_event: 1 }

  # Валидации
  validates :title, presence: true
  validates :start_time, presence: true
  validates :event_type, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  # Scope для активных событий
  scope :active, -> { where(deleted_at: nil, archived_at: nil) }

  # Методы проверки статуса и наличия мест
  def has_capacity?
    capacity.present?
  end

  def status
    return :deleted if deleted_at
    return :archived if archived_at
    is_published ? :published : :draft
  end
end