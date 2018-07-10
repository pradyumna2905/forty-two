Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    unauthenticated :user do
      root to: 'devise/registrations#new'
    end

    authenticated :user do
      root to: 'dashboards#show', as: :authenticated_root
    end
  end
end
