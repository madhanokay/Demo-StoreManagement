StoreManager::Application.routes.draw do
  get "unauthorized/index"
  get "unauthorized/profile"
  get "unauthorized/access_denied"
  match 'about' => 'unauthorized#about'
  devise_for :users do
    get '/'=> 'devise/sessions#new'
  end

  get 'users/edit'
  match 'users/profile' => 'user#profile'
  match 'users/edit_profile' => 'user#edit_profile'
  match 'users/update_profile' => 'user#update_profile'
  match 'unauthorized/index' => 'unauthorized#index'
  match 'users/current_request' => 'user#current_request'
  match 'users/user_cart_detail' => 'user#user_cart_detail'
  match 'users/user_cart_delete' => 'user#user_cart_delete'
  match 'users/report_list' => 'user#report_list'
  match 'users/notification' => 'user#notification'
  match 'users/notification_all' => 'user#notification_all'
  match 'users/reply_notification' => 'user#reply_notification'
  match 'users/create_reply_notification' => 'user#create_reply_notification'
  match 'users/delete_notification' => 'user#delete_notification'
  match 'users/edit_request' => 'user#edit_request'
  match 'users/update' => 'user#update'
  match 'users/destroy' => 'user#destroy'
  match 'users/compose_notification'=>'user#compose_notification'
  match 'users/create_compose_notification' => 'user#create_compose_notification'
  match 'users/change_password' => 'user#change_password'
  match 'users/update_password' => 'user#update_password'
  match 'users/send_notification_list' => 'user#send_notification_list'
  match 'users/read_notification' => 'user#read_notification'
  match 'users/notification_detail' => 'user#notification_detail'
  match 'users/move_to_trash' => 'user#move_to_trash'
  match 'users/trash_list' => 'user#trash_list'
  #location
  resources :location

  #category
  resources :category

  #admin controller

  match 'admin/users_list' => 'admin#users_list'
  match 'admin/edit_user' => 'admin#edit_user'
  match 'admin/update_user' => 'admin#update_user'
  match 'admin/block_user' => 'admin#block_user'
  match 'admin/show_user' => 'admin#show_user'
  match 'admin/damage_list'=> 'admin#damage_list'
  match 'admin/restore_damage'=> 'admin#restore_damage'
  match 'admin/update_product' => 'admin#update_product'

  #product
  resources :product do
    collection do
      get 'move_to_damage_list'
      post 'move_to_damage'
    end
  end
  match 'product/search_result' => 'product#search_result'
  #post 'product/create'
  #cart
  resources :cart, :except=> [:show]
  match 'cart/product_detail' => 'cart#product_detail'
  match 'cart/select_quantity' => 'cart#select_quantity'
  match 'cart/cart_detail' => 'cart#cart_detail'
  match 'cart/edit_item' => 'cart#edit_item'
  match 'cart/item_destroy' => 'cart#item_destroy'
  match 'cart/update_item' => 'cart#update_item'
  match 'cart/cart_destroy' => 'cart#cart_destroy'
  match 'cart/create_cart' => 'cart#create_cart'
  match 'cart/submit_cart' => 'cart#submit_cart'
  match 'cart/delete' => 'cart#delete'
  #item

  resources :item
  match 'item/item_detail/:id' => 'item#item_detail'
  match 'item/select_item/:id' => 'item#select_item'
  match 'item/create_item' => 'item#create_item'
  post 'item/new'
  match 'item/item_status' => 'item#item_status'

  #requests
  match 'request/index' => 'request#index'
  match 'request/cart_detail' => 'request#cart_detail'
  match 'request/approve_cart' => 'request#approve_cart'
  match 'request/approve_item' => 'request#approve_item'
  match 'request/cart_delete' => 'request#cart_delete'
  match 'request/item_delete' => 'request#item_delete'
  match 'request/edit_item' => 'request#edit_item'
  match 'request/move_to_que' => 'request#move_to_que'
  match 'request/que_list' => 'request#que_list'
  match 'request/record_list' => 'request#record_list'
  match 'request/recieve_item_list' => 'request#recieve_item_list'
  match 'request/send_notification' => 'request#send_notification'
  match 'request/recieve_item' => 'request#recieve_item'
  match 'request/create_notification' => 'request#create_notification'
  match 'request/move_to_damage_list' => 'request#move_to_damage_list'
  match 'request/move_to_damage' => 'request#move_to_damage'
  post 'request/search'
  put 'request/update'
 # match 'request/cart_detail_in_que' => 'request#cart_detail_in_que'
  #match 'request/approve_cart_in_que' => 'request#approve_cart_in_que'
  #match 'request/cart_delete_in_que' => 'request#cart_delete_in_que'
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
  root :to => 'devise/sessions#new'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
