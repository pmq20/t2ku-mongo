T2kuPragmatic::Application.routes.draw do

  constraints(Subdomain){match '/'=>'tasks#new'}
  
  devise_for :users,:controllers => { :registrations => "registrations" } do
    get "/register", :to => "registrations#new",as:'register'
    get "/login", :to => "devise/sessions#new",as:'login'
    get '/logout', :to => "devise/sessions#destroy", as:'logout'
  end
  
  resources :users
  resources :tasks
  resources :books do
    resources :items
  end
  resources :definitions
  resources :theorems
  resources :problems
  resources :references
  resources :authors
  resources :robots
  resources :helps
  get 'account' => 'account#index',:as=>'account'
  get 'downloads' => 'home#downloads',:as=>'downloads'
  get 'about' => 'home#about',:as=>'about'

  root :to => 'home#index'  
  post '/ajax/create_user' => 'ajax#create_user'
  post '/ajax/save_new_task_description' => 'ajax#save_new_task_description'
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
