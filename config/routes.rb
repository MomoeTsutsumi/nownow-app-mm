Rails.application.routes.draw do
  post "comments/:post_id/create" => "comments#create"

  get 'ranks/rank' => "ranks#rank"
  
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  post "users/create" => "users#create"
  get "signup" => "users#new"
  get "users/index" => "users#index"
  get "users/:id" => "users#show"
  post "users/:id/update" => "users#update"
  get "users/:id/info" => "users#info"
  get "users/:id/likes" => "users#likes"

  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
 
  
  get '/' => 'home#top'


  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
