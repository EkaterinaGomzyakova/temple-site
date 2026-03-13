Вот **правильно отформатированная версия README.md** (Markdown-структура, кодовые блоки, списки, заголовки). Я ничего не менял по смыслу, только **привёл к нормальному формату README**.

---

```md
# README

Проект сайта пространства **«Руфъ»**.  
Приложение написано на **Ruby on Rails 7.2.3**.

---

# Требования

Для запуска проекта необходимо:

- Ruby  
- Bundler  
- PostgreSQL  
- Node.js  
- Git  

Рекомендуемые версии:

```

Ruby >= 3.2
Rails = 7.2.3
Node >= 18
PostgreSQL >= 14

```

Проверить установленные версии:

```

ruby -v
rails -v
node -v
psql --version

```

---

# Установка Rails (если не установлен или нужно установить совместимую версию)

```

gem install rails -v 7.2.3

```

Проверка:

```

rails -v

```

Должно вывести:

```

Rails 7.2.3

```

---

# Клонирование проекта

```

git clone [git@github.com](mailto:git@github.com):EkaterinaGomzyakova/temple-site.git
cd temple_site

```

---

# Установка зависимостей (gems)

Все зависимости указаны в файле:

```

Gemfile

```

Установить их:

```

bundle install

```

Если bundler не установлен:

```

gem install bundler

```

---

# Настройка базы данных

Проект использует **PostgreSQL**.

Файл конфигурации:

```

config/database.yml

```

Если PostgreSQL уже установлен — дополнительных действий обычно не требуется.

---

# Создание базы данных

Создать базу:

```

rails db:create

```

Выполнить миграции:

```

rails db:migrate

```

Заполнить тестовыми данными:

```

rails db:seed

```

---

# Быстрый полный запуск

Самый простой способ развернуть проект:

```

bundle install
rails db:drop
rails db:create
rails db:migrate
rails db:seed
rails s

```

После этого сайт доступен по адресу:

```

[http://localhost:3000](http://localhost:3000)

```

---

# Сброс базы данных

Полностью удалить и пересоздать базу:

```

rails db:drop db:create db:migrate db:seed

```

---

# Миграции

Миграции находятся в:

```

db/migrate

```

Применить новые миграции:

```

rails db:migrate

```

Откатить последнюю:

```

rails db:rollback

```

---

# Seed данные (тестовые данные)

Seed файл:

```

db/seeds.rb

```

Запуск:

```

rails db:seed

```

Seeds создают:

- пользователей  
- клубы  
- события  
- товары  
- новости  

---

# Запуск сервера

В консоли:

```

rails server

```

или

```

rails s

```

Сайт будет доступен:

```

[http://localhost:3000](http://localhost:3000)

```

---

# Полезные команды Rails

Открыть консоль Rails:

```

rails console

```

Список маршрутов:

```

rails routes

```

Остановить сервер:

```

Ctrl + C

```

---

# Структура проекта

Основные папки для фронтенда:

```

app/
├── views
│    ├── layouts
│    ├── shared
│    ├── home
│    ├── shop
│    ├── news
│    ├── culture
│
├── assets
│    ├── stylesheets
│    ├── images
│
├── javascript

```

---

# Layout

Основной layout (шаблон страницы):

```

app/views/layouts/application.html.erb

````

Он содержит:

- navbar  
- yield (контент страницы)  
- footer  

Пример:

```erb
<body>
  <%= render "layouts/navbar" %>

  <%= yield %>

  <%= render "layouts/footer" %>
</body>
````

---

# Navbar (навигация)

Navbar находится:

```
app/views/shared/_navbar.html.erb
```

---

# Footer

Footer partial:

```
app/views/layouts/_footer.html.erb
```

---

# Где верстать страницы

Страницы находятся в:

```
app/views/
```

Примеры:

```
home/index.html.erb
shop/index.html.erb
culture/index.html.erb
news/index.html.erb
```

---

# Partial-компоненты

Rails активно использует **partials** (фрагменты страниц).

Пример:

```
app/views/news/_news.html.erb
```

Использование:

```erb
<%= render @news %>
```

Rails автоматически рендерит partial для каждой записи.

---

# Где писать CSS

Все стили находятся:

```
app/assets/stylesheets/
```

---

# Подключение CSS

Файл:

```
application.css
```

В нем подключаются все файлы из этой папки.

Стили применяются по **названиям классов**.

---

# Где лежат изображения

```
app/assets/images/
```

Пример структуры:

```
icons/
burger.svg
profile.svg
close.svg
```

Использование:

```erb
<%= image_tag "icons/burger.svg" %>
```

---

# JavaScript

JS находится:

```
app/javascript/
```

Главный файл:

```
application.js
```

Подключение файлов:

```javascript
import "./menu"
import "./calendar"
```

---

# Turbo

Проект использует **Turbo (Hotwire)**.

Поэтому вместо:

```
DOMContentLoaded
```

используется:

```javascript
document.addEventListener("turbo:load", () => {

})
```

---

# Пример JS

Файл:

```
app/javascript/menu.js
```

```javascript
document.addEventListener("turbo:load", () => {

  const burger = document.getElementById("burger-button")
  const menu = document.getElementById("menu-overlay")
  const close = document.getElementById("menu-close")

  if (!burger || !menu) return

  burger.addEventListener("click", () => {
    menu.classList.add("open")
  })

  close?.addEventListener("click", () => {
    menu.classList.remove("open")
  })

})
```

---

# ActiveStorage (изображения из базы)

Изображения загружаются через **ActiveStorage**.

Пример:

```erb
<%= image_tag product.image %>
```

---

# Turbo Frames

Карточки товаров используют Turbo Frames:

```erb
<turbo-frame id="product_<%= product.id %>">
```

Это позволяет обновлять интерфейс **без перезагрузки страницы**.

---

# Локализация

Проект использует русский язык.

Файл:

```
config/locales/ru.yml
```

Используется для:

* дат
* месяцев
* интерфейса

---

# Формат даты

Пример:

```
14 окт 2026
```

---

# Кастомные страницы ошибок

```
views/errors/
```

```
404.html
403.html
406.html
500.html
503.html
```

---

# Основные правила фронтенда

1. Использовать **partials для карточек**
2. JS писать через `turbo:load`
3. Иконки хранить в `assets/images/icons`
4. Секции верстать независимыми блоками