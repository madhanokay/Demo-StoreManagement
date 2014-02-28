module RequestHelper
	def request_link(cart)
		links = " "
		links += link_to 'view', action:'cart_detail', id:cart.id
		links += " | "
		links += link_to 'Approve', action:'approve_cart', id:cart.id
		links += " | "
		links += link_to 'delete', action:'cart_delete', id:cart.id, :confirm=>'Are You Sure??', method:'delete'
		links += " | "
		links += link_to ' move to que', action:'move_to_que', id:cart.id
		return links
	end

	def request_cart_item_link(item)
		links = " "
		links += link_to 'edit', action:'edit_item', id:item.id
		links += " | "
		links += link_to 'delete', action:'item_delete', id:item.id, :confirm=>'Are You Sure??', method:'delete'
		return links
	end

	def request_link_que(cart)
		links = " "
		links += link_to 'view', action:'cart_detail', id:cart.id
		links += " | "
		links += link_to 'Approve', action:'approve_cart', id:cart.id
		links += " | "
		links += link_to 'delete', action:'cart_delete', id:cart.id, :confirm=>'Are You Sure??', method:'delete'
		return links
	end

	def record_action_link(record)
		links = " "
		links += link_to 'Recieve', action:'recieve_item', id:record.id, method:'post'
		links += " | "
		links += link_to 'Send Notification', action:'send_notification', id:record.id
		links += "|"
		links += link_to 'move_to_damaged', action:'move_to_damage_list', id:record.id
		return links
	end

end
