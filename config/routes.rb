Rails.application.routes.draw do
  resources :posts
  resources :blogs do
    collection do
      get 'manage'
    end
    member do
      get 'posts'
      get 'post_details/:post_id', action: :post_details, as: :post_details
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Commontator::Engine => '/commontator'

  root "blogs#index"
end
