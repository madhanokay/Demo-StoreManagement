module CartHelper
	def cart_link(product)
		links = ""
		links += link_to 'view', action:'product_detail', id:product.id 
		links += " | "
		links += link_to 'request', action:'select_quantity', id:product.id, method:'post'
		return links
	end

	def item_link(cart)
		links = ""
		links += link_to 'details', action:'cart_detail', id:cart.id 
		links += " | "
		links += link_to 'Delete', action:'cart_destroy', id:cart.id, method:'post'
		return links
	end

	def item_action(item)
		links = ""
		links += link_to 'edit', action:'edit_item', id:item.id 
		links += " | "
		links += link_to 'Delete', action:'item_destroy', method:'delete'
		return links
	end
end
