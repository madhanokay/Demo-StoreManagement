class ItemController < ApplicationController
	before_filter :authenticate_user!
	before_filter :is_active_user

	def index
		if session[:cart_id]
			session[:cart_id] = nil
		end
			@cart = Cart.find(params[:id])
			session[:cart_id] = @cart.id
    @items = Item.of_current_cart(session[:cart_id])
  end

  def item_status
  	@product = Product.find(params[:id])
  	cart = Cart.where(:status =>true)
  	items = []
  	cart.map{|c| items += c.items.where(:product_id=>@product.id)}
  	@items = items
  end

  def new
  	@category = Category.all
  	@location = Location.all
  	if params[:post].blank? && params[:loc].blank?
  		@products = Product.all
	  elsif params[:post] || params[:loc]
  		conditions ={}
  		category_id = params[:post][:category]unless params[:post][:category].blank?
  		location_id = params[:loc][:location]unless params[:loc][:location].blank?
  		if category_id && location_id
  			conditions[:category_id] = params[:post][:category]
  			conditions[:location_id] = params[:loc][:location]
  		elsif category_id
  			conditions[:category_id] = params[:post][:category]
  		elsif location_id
  			conditions[:location_id] = params[:loc][:location]
  		end
  		@products = Product.find(:all, :conditions=> conditions)
 	  end
  end

  def create
  	@item = Item.new(params[:item])
		if @item.save
			flash[:notice] = "Successfully created..."
			redirect_to item_index_path
		else
			flash[:error] = @item.errors.full_messages.to_sentence
			render 'new'
  	end
  end

  def edit
    @item = Item.find(params[:id])
  end

	def update
		@item = Item.find(params[:item][:id])
		if @item.update_attributes(params[:item])
			price = @item.product.price
			quantity = @item.quantity
			item_price = quantity * price
			@item.update_attributes!(:total=>item_price)
			flash[:notice] = "Successfully Updated..."
			@items = Item.of_current_cart(session[:cart_id])
			render 'index'
		else
			flash[:error] = @item.errors.full_messages.to_sentence
			render 'edit'
		end
	end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
    	flash[:notice] = "Successfully Deleted..."
    else
    	flash[:error] = @item.errors.full_messages.to_sentence
    end
    @items = Item.of_current_cart(session[:cart_id])
    render 'index'
  end

	def select_item
		@product = Product.find(params[:id])
	end

	def item_detail
		@product = Product.find(params[:id])
	end

	def create_item
		@cart = Cart.find(session[:cart_id])
	 	if @cart
			@product = Product.find(params[:product][:id])
			quantity_value = params[:product][:quantity]
			@item = @cart.add_product_to_item(@product.id)
			@item.purchasing_date = params[:product][:purchasing_date]
	 		@item.quantity = quantity_value
	 		@item.return_date = params[:return_date_of_item]
	 		@item.total = @item.product.price * quantity_value.to_f
	  	if @item.save
	  		@items = Item.of_current_cart(session[:cart_id])
	 			flash[:notice] = "Added Successfully"
	 			render 'index'
			else
				flash[:error] = @item.errors.full_messages.to_sentence
				render 'select_item'
			end
		end
	end
end
