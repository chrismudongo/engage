Rails.application.routes.draw do

  resources :questions
  resources :surveys
  resources :answers
  root to: 'grid_fs_files#index'

  resources :grid_fs_files
  get '/grid_fs_files/contents/:id/', to: 'grid_fs_files#contents', as: 'contents'
end
