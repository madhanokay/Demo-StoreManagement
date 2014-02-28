class CartController < ApplicationController
	before_filter :authenticate_user!
	before_filter :is_active_user

	def index
		@carts = Cart.of_current_user(current_user)
	end

	def new
		@cart = Cart.new
		@products = Product.all
	end

	def create_cart
		carts = Cart.of_current_user(current_user)
		if carts.count<1
			cart = Cart.new(:user_id => current_user.id)
			if cart.save
				flash[:notice] = "Cart created Succesflly"
			else
				flash[:error] = cart.errors.full_messages.to_sentence
			end
		else
			flash[:error] = "please submit the existing cart"
		end
		redirect_to cart_index_path
	end

	def submit_cart
		cart = Cart.find(params[:id])
		if cart.update_attributes(:status =>true, :total_price=> cart.whole_price)
			flash[:notice] = "Cart Submitted Succesflly"
		else
			flash[:error] = cart.errors.full_messages.to_sentence
		end
		redirect_to cart_index_path
	end

	def select_quantity
		@product = Product.find(params[:id])
	end

	def product_detail
		@product = Product.find(params[:id])
	end

	def cart_detail
		cart = Cart.find(params[:id])
		@items = cart.items
	end

	def edit_item
		@item = Item.find(params[:id])
	end

	def update_item
		@item = Item.find(params[:item][:id])
		cart_total_price = @item.quantity * @item.product.price
		if @item.update_attributes(params[:item])
			@item.cart.update_attributes!(:total=>cart.total_price)
			flash[:notice] = "Succesfully Updated"
			redirect_to cart_index_path
		else
			flash[:error] = @item.errors.full_messages.to_sentence
			render 'edit_item'
		end
	end

	def delete
		@cart = Cart.find(params[:id])
		if @cart.destroy
			flash[:notice] = "Deleted Succesfully"
		else
			flash[:error] = @cart.errors.full_messages.to_sentence
		end
		redirect_to cart_index_path
	end
end
