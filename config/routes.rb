WebConsole::Engine.routes.draw do
  root to: 'console_sessions#index'

  resources :console_sessions do
    member do
      put :input
      #get :pending_output
      get :show
      put :configuration
    end
  end
end
