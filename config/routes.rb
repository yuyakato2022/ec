Rails.application.routes.draw do


  devise_for :customers, path: :me, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }


  root to: 'public/homes#top'




  scope module: :public do
    # get 'customer/edit' => 'customers#edit'
    # patch 'customer/edit' => 'customers#update'
    get 'about' => 'homes#about'
    get 'orders/complete' => 'orders#complete'
    post 'orders/confirm' => 'orders#confirm'
    resources :orders, only: [:new, :index, :show, :create]
    resources :cart_items, only: [:index, :create, :update, :destroy]do
      delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    end
    resources :items, only: [:show, :index] do
      resources :reviews, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :deliveries, only: [:index, :destroy, :edit, :update, :create]
    resource :customers, only: [:show,:edit,:update] do
      get :favorites
    end

    patch 'customers/withdraw' => 'customers#withdraw'
    get 'customers/quit' => 'customers#quit'
  end



  namespace :admin do
    get '/' => 'homes#top'
    resources :orders, only: [:show, :update]
    resources :genres, only: [:index, :edit, :update, :create]
    resources :items, only: [:index, :show, :new, :edit, :update, :create]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :order_details, only: [:update]
  end

end
