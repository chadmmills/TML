Rails.application.routes.draw do
  resources :events do
    resources :mailing_lists, only: [:new, :create], path: "mailing-lists"
  end
  resources :contacts
  resources :contact_uploads, only: :create
  resources :uploads, only: :destroy
  resources :mailing_lists, only: :show, path: "mailing-lists"
  resources :mailing_list_contacts, only: [:create, :update], path: "mailing-list-contacts"
  resource :mailing_list_contacts_toggle, only: [:update], path: "mailing-list-contacts-toggle"

  root to: "events#index"
end
