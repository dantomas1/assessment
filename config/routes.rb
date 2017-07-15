Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"
   resources :posts
   resources :publish, only:[:index]
   resources :draft, only:[:index]
  #match 'posts/all' => 'users#publish_all', :as => :publish_all, :via => :put
   #resources :users do
   # resources :posts do
   #  resources :comment
   # end
   #end
   resources :users
   resources :comments
   resources :responses
   resources :gloves
   #scope :api do
   # get "/responses(.:format)" => "responses#index"
   # get "/responses/:id(.:format)" => "responses#show"
   # get "/responses/:id/posts(.:format)" => "responses#posts"
   #end
  # end
end
