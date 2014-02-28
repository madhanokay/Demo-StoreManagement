class UserController < ApplicationController
before_filter :authenticate_user!

	def profile
		@user = current_user
		@user_detail = @user.user_detail
	end

	def edit_profile
		@user = current_user
		@user_detail = @user.user_detail
	end

	def update_profile
		@user = current_user
		@user_detail = @user.user_detail
		if @user_detail.update_attributes(params[:user_detail])
			flash[:notice] = "Profile Updated Succesfully"
			redirect_to users_profile_path
		else
			flash[:error] = @user_detail.errors.full_messages.to_sentence
			render 'edit_profile'
		end
	end

	def current_request
		@carts = Cart.where(:user_id=> current_user.id, :status=>true)
	end

	def user_cart_detail
		cart = Cart.find(params[:id])
		@items = cart.items
	end

	def user_cart_delete
		@cart = Cart.find(params[:id])
		if @cart.user == current_user
			if @cart.destroy
				flash[:notice] ="Cart Deleted Succesfully"
			else
				flash[:error] = @cart.errors.full_messages.to_sentence
			end
			redirect_to users_current_request_path
		else
			redirect_to unauthorized_access_denied_path
		end
	end

	def report_list
		@records = Record.of_current_user(current_user)
	end
#Notification Actions
	def notification
		@notifications = Notification.of_current_user(current_user).where(:delete_status=>false)
		@user = current_user
	end

	def trash_list
		@notifications = Notification.of_current_user(current_user).where(:delete_status=>true)
	end

	def compose_notification
		@notification = Notification.new
		@admin = User.find_by_user_role 101
	end

	def reply_notification
		@old_notification = Notification.find(params[:id])
		if current_user == @old_notification.user
			@notification = Notification.new
		else
			redirect_to unauthorized_access_denied_path
		end
	end

	def create_compose_notification
		@notification = Notification.new(params[:notification])
		@notification.from_user_id = current_user.id
		if @notification.save
			@notification.update_attributes!(:status =>true)
			flash[:notice] = "Notification Sent Succesfully"
		else
			flash[:error] = @notification.errors.full_messages.to_sentence
		end
		redirect_to users_notification_path
	end

	def send_notification_list
		user = current_user
		@notifications = Notification.where(:from_user_id=>user.id, :status=>true)
	end

	def read_notification
		@notification = Notification.find(params[:id])
		if current_user == @notification.user
			@notification.update_attributes!(:read_status=>true)
		else
			redirect_to unauthorized_access_denied_path
		end
	end

	def notification_detail
		@notification = Notification.find(params[:id])
		if current_user == @notification.sent
		else
			redirect_to unauthorized_access_denied_path
		end
	end

	def create_reply_notification
		@notification = Notification.new(params[:notification])
		@notification.from_user_id = current_user.id
		if @notification.save
			@notification.update_attributes!(:status=>true)
			flash[:notice] = "Notification Sent Succesfully"
		else
			flash[:error] = @notification.errors.full_messages.to_sentence
		end
		redirect_to users_notification_path
	end

	def move_to_trash
		@notification = Notification.find(params[:id])
		if current_user == @notification.user
			status = @notification.delete_status
			if @notification.update_attributes(:delete_status=>!status)
				flash[:notice] = "Message has been Moved Succesfully"
			else
				flash[:error] = @notification.errors.full_messages.to_sentence
			end
			redirect_to users_notification_path
		else
			redirect_to unauthorized_access_denied_path
		end
	end
# till here Notification Actions
	def edit_request
    @item = Item.find(params[:id])
  end

	def update
		@item = Item.find(params[:item][:id])
		if @item.update_attributes(params[:item])
			item_price = @item.quantity * @item.product.price
			@item.update_attributes!(:total=>item_price)
			flash[:notice] = "Successfully Updated..."
			cart = @item.cart
			@items = cart.items
			render 'user_cart_detail'
		else
			flash[:error] = @item.errors.full_messages.to_sentence
			render 'edit_request'
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

  def change_password
  	@user = current_user
  end

  def update_password
  	@user = User.find(current_user.id)
    if @user.update_with_password(params[:user])
      sign_in @user,:bypass => true
      flash[:notice] = "Password Updated Succesfully!!!"
      redirect_to users_profile_path
    else
    	flash[:error] = @user.errors.full_messages.to_sentence
    	 redirect_to users_change_password_path
    end
  end
end
