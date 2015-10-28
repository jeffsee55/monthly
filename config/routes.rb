Rails.application.routes.draw do
  resources :users, only: :show do
    collection do
      get 'class_details'
    end
  end
  resources :channels, only: :show do
    collection do
      get 'class_details'
    end
  end
  resources :leases, only: :show do
    collection do
      get 'class_details'
    end
  end
  resources :models, only: :show do
    collection do
      get 'class_details'
    end
  end
  resources :units, only: :show do
    collection do
      get 'class_details'
    end
  end
  resources :subscriptions, only: :show do
    collection do
      get 'class_details'
    end
  end
end
