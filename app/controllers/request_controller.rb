class RequestController < ApplicationController
	before_filter :authenticate_user!
	before_filter :is_admin

	def index
		@carts = Cart.where(:status=>true, :move_to_que=>false)
	end

	def que_list
		@carts = Cart.where(:move_to_que=>true)
	end

	def cart_detail
		@cart = Cart.find(params[:id])
		@items = @cart.items
	end

	def cart_delete
		@cart = Cart.find(params[:id])
		if @cart.destroy
			flash[:notice] = "Deleted Succesfully"
			Notification.delete_cart(@cart)
		else
			flash[:error] = @cart.errors.full_messages.to_sentence
		end
			redirect_to :back
	end

	def approve_cart
		@cart = Cart.find(params[:id])
		@items = @cart.items
		@items.each do |item|
			item_quantity = item.quantity
			product_quantity = item.product.quantity
			if item_quantity <= product_quantity && item.purchasing_date == Date.today
				new_quantity = product_quantity - item_quantity
				item.product.update_attributes!(:quantity=>new_quantity)
				Record.approve_cart(item)
				item.destroy
			else
				flash[:notice] = "Cant approve all the items "
			end
		end
		if @cart.items.count == 0
			Notification.approve_cart_success(@cart)
			@cart.destroy
		end
		redirect_to :back
	end

	def approve_item
		item = Item.find(params[:id])
		@cart = item.cart
		item_quantity = item.quantity
		product_quantity = item.product.quantity
		if item_quantity <= product_quantity
			new_quantity = product_quantity - item_quantity
			item.product.update_attributes!(:quantity=>new_quantity)
			Notification.approve_item(item)
			Record.approve_item(item)
			item.destroy
		else
			flash[:error] = "Cant approve the items "
		end
		if @cart.items.count == 0
			Notification.approve_cart_success(@cart)
			@cart.destroy
			redirect_to request_index_path
		else
			redirect_to request_cart_detail_path(@cart.id)
		end
	end

	def move_to_que
		@cart = Cart.find(params[:id])
		if @cart.update_attributes(:move_to_que=>true)
			Notification.move_to_que(@cart)
			flash[:notice] = "Cart has been moved to que Succesfully"
		else
			flash[:error] = @cart.errors.full_messages.to_sentence
		end
		redirect_to request_index_path
	end

	def record_list
		if params[:category].blank?
			@records = Record.all
		else
			conditions = {}
			from = params[:purchase_date_from].to_date unless params[:purchase_date_from].blank?
			to = params[:purchase_date_to].to_date unless params[:purchase_date_to].blank?
			if (from && to)
				conditions[:purchase_date] = params[:purchase_date_from]..params[:purchase_date_to]
			end
			conditions[:category_id] = params[:category][:id] unless params[:category][:id].blank?
			@records = Record.find(:all, :conditions=> conditions)
		end
	end

	def recieve_item_list
		@records = Record.find(:all, :conditions =>["item_recieve_status = ?
									OR item_recieve_status = ? OR item_recieve_status = ?",
									'Delay ', 'Item Not Recieved Yet', 'Under Usage '])
	end

	def send_notification
		@record = Record.find(params[:id])
		@user = @record.user
		@admin = current_user
		@notification = Notification.new
	end

	def create_notification
		@notification = Notification.new(params[:notification])
		if @notification.save
			flash[:notice] = "Notification Sent Succesfully"
			redirect_to request_record_list_path
		else
			flash[:error] = @notification.errors.full_messages.to_sentence
			@record = Record.find(params[:id])
			@user = @record.user
			@admin = current_user
			render 'send_notification'
		end
	end

	def recieve_item
		@record = Record.find(params[:id])
		if @record.update_attributes(:return_status=>true, :item_recieve_status=>'Recieved')
			@record.product.quantity += @record.quantity
			@record.product.update_attributes!(:quantity=>@record.product.quantity)
			Notification.return_item(@record)
			flash[:notice] = "Item Recieved Succesfully"
		else
			flash[:error] = @record.errors.full_messages.to_sentence
		end
		redirect_to request_recieve_item_list_path
	end

	def move_to_damage_list
		@record = Record.find(params[:id])
	end

	def move_to_damage
		@record = Record.find(params[:id])
		quantity = params[:record][:quantity].to_i
		initial_quantity = @record.quantity
		if initial_quantity == quantity
			if @record.update_attributes(:return_status=>true,:move_to_damage=>true,
													:item_recieve_status=>'Damaged')
				Notification.return_item(@record)
				DamageProductList.create_damage_list(@record)
				flash[:notice] = "Moved to damage list Succesfully"
			else
				flash[:error] = @record.errors.full_messages.to_sentence
			end
		else
			rest_quantity = initial_quantity - quantity
			if @record.update_attributes(:quantity=>rest_quantity)
				Record.create_damage_record(@record,quantity)
				DamageProductList.create_damage_list_with_quantity(@record,quantity)
				flash[:notice] = "#{quantity} items moved to damage list Succesfully"
			else
				flash[:error] = @record.errors.full_messages.to_sentence
			end
		end
			redirect_to request_recieve_item_list_path
	end

	def edit_item
    @item = Item.find(params[:id])
  end

	def update
		@item = Item.find(params[:item][:id])
		if @item.update_attributes(params[:item])
			item_price = @item.quantity * @item.product.price
			@item.update_attributes!(:total=>item_price)
			Notification.edit_request(@item)
			flash[:notice] = "Successfully Updated..."
			@items = Item.of_current_cart(session[:cart_id])
			render 'cart_detail'
		else
			flash[:error] = @item.errors.full_messages.to_sentence
			render 'edit_item'
		end
	end

	def item_delete
    @item = Item.find(params[:id])
    if @item.destroy
    	flash[:notice] = "Successfully Deleted..."
    else
    	flash[:error] = @item.errors.full_messages.to_sentence
    end
    @items = Item.of_current_cart(session[:cart_id])
    render 'cart_detail'
  end
end
