# frozen_string_literal: true

Rails.application.routes.draw do
  root 'github#index'
  get 'search', to: 'github#search'
end
