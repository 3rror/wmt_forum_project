Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "topics#index"

  devise_for :users

  get "/search", to: "search#index"

  resources :topic_sections, only: :show
  resources :subscribed_topics, only: :index

  resources :topics, shallow: true do
    resources :posts, except: [:index, :show]
    get '/subscribe', to: 'topics#subscribe', as: :subscribe
    get '/unsubscribe', to: 'topics#unsubscribe', as: :unsubscribe
  end
end
