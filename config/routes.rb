Rails.application.routes.draw do
  resources :events do
    resources :invitation_lists
  end
  resources :contacts
  resources :contact_uploads, only: :create

  root to: "events#index"
end
