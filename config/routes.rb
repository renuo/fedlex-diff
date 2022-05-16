# frozen_string_literal: true

Rails.application.routes.draw do
  get '/document_page', to: 'document_page#index'
  root 'search#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'home/check'
end
