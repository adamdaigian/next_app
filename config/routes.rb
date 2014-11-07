EbV3::Application.routes.draw do
  # You can have the root of your site routed with "root"

 # scope APP_CONFIG['eb_root'] do
    root 'static_pages#index'
    mount Resque::Server, :at => "/resque"
    get   "/invitations" => "invitations#index"
    get   "/accounts" => "accounts#index"


    get   "/apply" => "invitations#new"
    post  "/apply" => "invitations#create"
    get   "/welcome/:invitation_token" => "invitations#welcome", as: :welcome
    post  "/validate/:invitation_token" => "invitations#validate"

    get   "/login" => "accounts#login", as: :login
    get   "/signup" => "accounts#signup", as: :signup
    post  "/signup" => "accounts#create", as: :create_account

    get   "/processing/:account_token" => "accounts#processing", as: :processing
    get   "/checkstatus/:account_token" => "accounts#check_status"


    get "/auth/:provider/callback" => "authentications#create"
    
    get "/signup_callback" => "authentications#create_account_from_eb", as: :signup_callback

 # end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
