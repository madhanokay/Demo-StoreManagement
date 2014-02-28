module ItemHelper
	def item_link(item)
		links = ""
		links += link_to 'Edit', action:'edit', id:item.id 
		links += " | "
		links += link_to 'Delete', item_path(item), method:'delete'
		return links
	end

	def add_item_link(product)
		links = ""
		links += link_to 'View', action:'item_detail', id:product.id 
		links += " | "
		links += link_to 'Add', action:'select_item', id:product.id
		return links
	end

end
