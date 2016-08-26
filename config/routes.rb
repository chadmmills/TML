Rails.application.routes.draw do
  resources :events do
    resources :invitation_lists, only: [:new, :create]
  end
  resources :contacts
  resources :contact_uploads, only: :create
  resources :uploads, only: :destroy
  resources :invitation_lists, only: :show

  root to: "events#index"
end
