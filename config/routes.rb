Rails.application.routes.draw do
  scope module: :public do
    root to: 'homes#top'
    get 'about', to: 'homes#about'
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
    resources :customers, only: [:show, :edit, :update] do
      collection do
        get :unsubscribe
        patch :withdraw
      end
    end
    resources :items, only: [:index, :show]
  end

  namespace :admin do
    root to: 'homes#top'
    resources :order_details, only: :update
    resources :orders, only: [:show, :update]
    resources :customers, except: [:destroy, :create, :new]
    resources :genres, except: [:destroy, :show, :new]
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
