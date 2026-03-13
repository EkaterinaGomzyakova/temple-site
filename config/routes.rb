Rails.application.routes.draw do
  get "home/index"
  # ---------------------------------
  # Devise для авторизации пользователей
  # ---------------------------------
  devise_for :users

  # ---------------------------------
  # Главная страница
  # ---------------------------------
# Главная страница
root "home#index"
# Чтобы был хелпер home_path
get "home", to: "home#index"
  
  # ---------------------------------
  # Страницы меню (статические)
  # ---------------------------------
  get "education", to: "pages#education"
  get "culture", to: "pages#culture"
  get "shop", to: "pages#shop"
  get "cafe", to: "pages#cafe"

  # ---------------------------------
  # События
  # ---------------------------------
  resources :events

  # ---------------------------------
  # Клубы и заявки в клуб
  # ---------------------------------
  resources :clubs do
    resources :club_memberships, only: [:index, :create, :update, :destroy]
  end

  # ---------------------------------
  # Новости
  # ---------------------------------
  resources :news

  # ---------------------------------
  # Церковная лавка
  # ---------------------------------
  resources :products, only: [:index, :show]
  resources :cart_items, only: [:index, :create, :update, :destroy]
  resources :orders, only: [:index, :show, :create, :update]

  # ---------------------------------
  # Для совместимости с кастомными путями (если нужны)
  # ---------------------------------
  # signup, login, logout – не нужны, если используем Devise
  # get "signup", to: "users#new"
  # post "signup", to: "users#create"
  # get "login", to: "sessions#new"
  # post "login", to: "sessions#create"
  # delete "logout", to: "sessions#destroy"

  # ---------------------------------
  # Пространство для будущего namespace админки
  # ---------------------------------
  # namespace :admin do
  #   resources :users
  #   resources :clubs
  #   resources :events
  #   resources :products
  #   resources :news
  #   resources :orders
  # end

  # Страницы ошибок
  match "/403", to: "errors#forbidden", via: :all
  match "/404", to: "errors#not_found", via: :all
  match "/406", to: "errors#not_acceptable", via: :all
  match "/422", to: "errors#unprocessable", via: :all
  match "/500", to: "errors#internal", via: :all
  match "/503", to: "errors#service_unavailable", via: :all 
end

