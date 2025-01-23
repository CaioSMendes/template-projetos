Rails.application.routes.draw do
  get "public/logs"

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :public, only: [:show, :index]  # Aqui também pode gerar rotas públicas

  authenticated :user, ->(user) { user.admin? } do
    root 'admin#index', as: :admin_root
  end

  authenticated :user, ->(user) { user.user? } do
    root 'user#index', as: :user_root
  end

  unauthenticated do
    root 'home#index'
  end

  get 'user/index', to: 'user#index'
  get 'admin/index', to: 'admin#index'

  # Rota para verificação de saúde do sistema
  get "up" => "rails/health#show", as: :rails_health_check
end
