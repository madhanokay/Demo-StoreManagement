module ProductHelper
	def product_new
		link_to 'Add Product', new_product_path, class:'btn btn-primary'
	end

	def product_link(product)
		links = " "
		links += link_to 'view', action:'show', id:product.id
		links += " | "
		links += link_to 'edit', action:'edit', id:product.id
		links += " | "
		links += link_to 'delete', product_path(product), :confirm=>'Are You Sure??', method:'delete'
		links += " | "
		links += link_to 'Damage List', action:'move_to_damage_list', id:product.id
		return links

	end
end
