Rails.application.routes.draw do
  resources :products, only: [:index, :show, :create, :update, :destroy], shallow: true do
    collection do
      get :search
    end
  end
end
