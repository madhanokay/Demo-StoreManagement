class AdminController < ApplicationController
	before_filter :authenticate_user!
	before_filter :is_admin

	def users_list
		@user_details = User.select([:id,:status]).where(user_role:201).map{|user| user.user_detail}
	end

	def show_user
		@user = User.find(params[:id])
		@user_detail = @user.user_detail
	end

	def edit_user
		@user = User.find(params[:id])
		@user_detail = @user.user_detail
	end

	def update_user
		user = User.find(params[:id])
		@user_detail = user.user_detail
		if @user_detail.update_attributes(params[:user_detail])
			flash[:notice] = "Profile Updated Succesfully"
			redirect_to admin_users_list_path
		else
			flash[:error] = @user_detail.errors.full_messages.to_sentence
			render 'edit_user'
		end
	end

	def block_user
		@user = User.find(params[:id])
		status = params[:status]
		if @user.update_attributes(:status=>status)
			flash[:notice] = "Status changed Succesfully"
		else
			flash[:error] = @user.errors.full_messages.to_sentence
		end
		redirect_to admin_users_list_path
	end

	def damage_list
		@damage_list = DamageProductList.all
	end

	def restore_damage
		@damage_item = DamageProductList.find(params[:id])
	end

	def update_product
		@damage_item = DamageProductList.find(params[:damage_product_list][:id])
		@product = Product.find(params[:damage_product_list][:product_id])
		quantity = params[:damage_product_list][:quantity].to_i
		if @damage_item.quantity == quantity
			updated_quantity = @product.quantity + quantity
			if @product.update_attributes(:quantity=>updated_quantity)
				@damage_item.destroy
				flash[:notice] = "Product Restored Succesfully"
			else
				flash[:error] = @product.errors.full_messages.to_sentence
			end
		else
			new_quantity = @damage_item.quantity - quantity
			updated_quantity = @product.quantity + quantity
			if @product.update_attributes(:quantity=>updated_quantity)
				@damage_item.update_attributes(:quantity=>new_quantity)
				flash[:notice] = "#{quantity} restored to product Succesfully"
			else
				flash[:error] = @product.errors.full_messages.to_sentence
			end
		end
		redirect_to admin_damage_list_path
	end
end
