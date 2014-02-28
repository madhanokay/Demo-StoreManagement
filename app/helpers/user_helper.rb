module UserHelper
	def current_user_request_link(cart)
		links = " "
		links += link_to 'view', action:'user_cart_detail', id:cart.id
		links += " | "
		links += link_to 'delete', action:'user_cart_delete',id:cart.id, :confirm=>'Are You Sure??', method:'delete'
		return links
	end

	def request_item_link(item)
		links = ""
		links += link_to 'Edit', action:'edit_request', id:item.id 
		return links
	end

	#def notification_link(notification)
	#	link_to 'Delete', action:'delete_notification', id:notification.id, :class=>'btn btn-primary', confirm:'Are you sure ?'
	#end
end
