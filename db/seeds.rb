# db/seeds.rb

puts "Starting seeds..."

# ---------------------------------
# Подготовка картинок
# ---------------------------------
image_files = Dir[Rails.root.join("db/seeds_images/*.{jpg,jpeg,png}")]
raise "Нет файлов для загрузки! Помести картинки в db/seeds_images" if image_files.empty?

def random_image(files)
  path = files.sample
  {
    io: File.open(path),
    filename: File.basename(path)
  }
end

# ---------------------------------
# Очистка таблиц (сначала дочерние, потом родительские)
# ---------------------------------
puts "Clearing tables..."
OrderItem.destroy_all
Order.destroy_all
CartItem.destroy_all
Product.destroy_all
ProductCategory.destroy_all
News.destroy_all
EventTag.destroy_all
Tag.destroy_all
Event.destroy_all
ClubMembership.destroy_all
Club.destroy_all
Profile.destroy_all
User.destroy_all

# ---------------------------------
# Пользователи и профили
# ---------------------------------
# ---------------------------------
# Пользователи и профили
# ---------------------------------
puts "Creating users and profiles..."

# Пользователь admin
admin = User.create!(
  email: "admin@temple.ru",
  password: "123456",
  password_confirmation: "123456",
  role: :admin
)
# создаём профиль через блок, сразу после сохранения пользователя
admin.create_profile!(name: "Иван Петров").tap do |profile|
  profile.avatar.attach(
    io: File.open(image_files.sample),
    filename: File.basename(image_files.sample)
  )
end

# Пользователь user
user = User.create!(
  email: "user@temple.ru",
  password: "123456",
  password_confirmation: "123456",
  role: :user
)
user.create_profile!(name: "Мария Иванова").tap do |profile|
  profile.avatar.attach(
    io: File.open(image_files.sample),
    filename: File.basename(image_files.sample)
  )
end# ---------------------------------
# Пользователи и профили
# ---------------------------------
puts "Creating users and profiles..."

admin = User.find_or_create_by!(email: "admin@temple.ru") do |u|
  u.password = "123456"
  u.password_confirmation = "123456"
  u.role = :admin
end

admin_profile = admin.profile || admin.create_profile!(
  name: "Иван Петров"
)
admin_profile.avatar.attach(
  io: File.open(image_files.sample),
  filename: File.basename(image_files.sample)
)

user = User.find_or_create_by!(email: "user@temple.ru") do |u|
  u.password = "123456"
  u.password_confirmation = "123456"
  u.role = :user
end

user_profile = user.profile || user.create_profile!(
  name: "Мария Иванова"
)
user_profile.avatar.attach(
  io: File.open(image_files.sample),
  filename: File.basename(image_files.sample)
)
# ---------------------------------
# Категории товаров
# ---------------------------------
puts "Creating product categories..."
categories = %w[иконы свечи текстиль сувениры керамика подарочные_наборы открытки книги крестики ладан]
categories_objects = categories.map.with_index(1) { |name, i| ProductCategory.create!(name: name, position: i) }

# ---------------------------------
# Товары
# ---------------------------------
puts "Creating products..."
products = []
categories_objects.each do |cat|
  2.times do |i|
    product = Product.create!(
      name: "#{cat.name.capitalize} №#{i+1}",
      description: "Описание товара #{cat.name.capitalize}. Подходит для дома и подарков.",
      price: 50 + rand(50),
      stock_quantity: 5 + rand(5),
      product_category: cat,
      slug: "#{cat.name}-#{i+1}",
      position: i+1,
      created_by: admin
    )
    product.image.attach(random_image(image_files))
    products << product
  end
end

# ---------------------------------
# Клубы
# ---------------------------------
puts "Creating clubs..."
club1 = Club.create!(
  name: "Иконопись",
  description: "Клуб по изучению техники иконописи.",
  admin_user: admin,
  slug: "ikonopis",
  position: 1
)
club1.image.attach(random_image(image_files))

club2 = Club.create!(
  name: "Книжный клуб",
  description: "Обсуждаем книги о культуре и истории.",
  admin_user: admin,
  slug: "book_club",
  position: 2
)
club2.image.attach(random_image(image_files))

# ---------------------------------
# Участие в клубах
# ---------------------------------
puts "Creating club memberships..."
ClubMembership.create!(user: user, club: club1, status: :approved)
ClubMembership.create!(user: user, club: club2, status: :pending)

# ---------------------------------
# События
# ---------------------------------
puts "Creating events..."
event1 = Event.create!(
  title: "Мастер-класс по иконописи",
  description: "Участники познакомятся с основами иконописной традиции.",
  start_time: Time.current + 3.days,
  location: "Образовательный центр, зал 1",
  price: 0,
  capacity: 15,
  has_registration: true,
  external_registration_url: "https://timepad.ru/event/1",
  event_type: :club_event,
  club: club1,
  created_by: admin,
  slug: "masterklass-ikonopis",
  is_published: true
)
event1.cover_image.attach(random_image(image_files))
3.times { event1.images.attach(random_image(image_files)) }

event2 = Event.create!(
  title: "Концерт органной музыки",
  description: "Концерт духовной музыки в храме.",
  start_time: Time.current + 7.days,
  location: "Храм святого Николая",
  price: 0,
  capacity: nil,
  has_registration: false,
  event_type: :culture_event,
  created_by: admin,
  slug: "concert-organ",
  is_published: true
)
event2.cover_image.attach(random_image(image_files))
3.times { event2.images.attach(random_image(image_files)) }

# ---------------------------------
# Теги событий
# ---------------------------------
puts "Creating tags..."
tags = %w[концерты клубы ярмарки выставки лектории кинопоказы]
tag_objects = tags.map { |t| Tag.create!(name: t) }
event2.tags << tag_objects.sample(2)

# ---------------------------------
# Новости
# ---------------------------------
puts "Creating news..."
news1 = News.create!(
  title: "Открытие выставки иконописи",
  content: "<p>В культурном пространстве открылась новая выставка иконописи.</p>",
  slug: "exhibition-ikonopis",
  created_by: admin,
  is_published: true,
  position: 1
)
3.times { news1.images.attach(random_image(image_files)) }

news2 = News.create!(
  title: "Новый курс по церковному пению",
  content: "<p>Стартует курс по традиционному церковному пению.</p>",
  slug: "church-choir-course",
  created_by: admin,
  is_published: true,
  position: 2
)
3.times { news2.images.attach(random_image(image_files)) }

# ---------------------------------
# Корзина и заказ
# ---------------------------------
puts "Creating cart items and orders..."
cart_item = CartItem.create!(user: user, product: products.sample, quantity: 2)

order = Order.create!(
  user: user,
  status: :pending,
  total_price: cart_item.product.price * cart_item.quantity,
  delivery_type: :pickup,
  address: "ул. Тестовая, д.1",
  phone: "+7 999 000 11 22",
  comment: "Проверка заказа"
)

OrderItem.create!(
  order: order,
  product: cart_item.product,
  quantity: cart_item.quantity,
  price: cart_item.product.price
)

puts "Seeds finished successfully!"