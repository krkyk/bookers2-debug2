Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
    resource :favorites, only:[:create,:destroy]
    resources :book_comments, only:[:create,:destroy]
  end
  get "search_tag"=>"books#search_tag"
  resources :users, only: [:index,:show,:edit,:update]do
    resource :relationships, only:[:create,:destroy]
    get "followings"=>"relationships#followings",as:"followings"
    get "followers"=>"relationships#followers",as:"followers"
  end
  resources :messages,only: [:create,:show]
  get "search"=>"searches#search"
  resources :groups do
    get "join"=>"groups#join"
    get "new/mail"=>"groups#new_mail"
    get "send/mail"=>"groups#send_mail"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end