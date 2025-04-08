require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users
  root "projects#index"

  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  resources :projects do
    resources :sprints do
      resources :tasks do
        resources :comments, only: [:create, :destroy]
        resources :attachments, only: [:create, :destroy]
      end
    end
  end
end
