Rails.application.routes.draw do

  namespace :public do

    # get '/customer/unsubscribe', to: 'customers#unsubscribe'


  end
  scope module: :public do
    root to: 'homes#top'
    get 'customers/unsubscribe', to: 'customers#unsubscribe'
    patch 'customers/withdraw', to: 'customers#withdraw'
    get "orders/confirm" => "orders#confirm"
    get     'about',                      to: 'homes#about'
    get     'customers/mypage',           to: 'customers#show'
    get     'customers/information/edit', to: 'customers#edit'
    patch   'customers/information',    to: 'customers#update'
    resources :addresses, except: [:show, :new]
    resources :orders, only: [:index, :show, :new, :create] do
      collection do
        post :comfirm
        get :complete
      end
    end
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete :destroy_all
      end
    end
    # resource :customers, only: [:show, :edit, :update]
    resources :items, only: [:index, :show]
  end

  namespace :admin do
    root to: 'homes#top'
    resources :order_details, only: :update
    resources :orders, only: [:show, :update]
    resources :customers, except: [:destroy, :create, :new]
    resources :genres, except: [:show, :new, :destroy]
    resources :items, except: :destroy
  end







  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
end
