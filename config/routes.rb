Rails.application.routes.draw do
  get 'groups/index'
  get 'groups/show'
  get 'groups/create'
  get 'groups/update'
  get 'groups/edit'
  get 'groups/new'
  get 'index/show'
  get 'index/create'
  get 'index/update'
  get 'index/edit'
  get 'index/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  devise_for :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
    resource :favorites, only:[:create,:destroy]
    resources :book_comments, only:[:create,:destroy]
  end
  resources :users, only: [:index,:show,:edit,:update]do
    resource :relationships, only:[:create,:destroy]
    get "followings"=>"relationships#followings",as:"followings"
    get "followers"=>"relationships#followers",as:"followers"
  end
  resources :messages,only: [:create,:show]
  get "search"=>"searches#search"
  resources :groups
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end