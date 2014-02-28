module CategoryHelper
	def category_link(category)
		warning = "Deleting the Category leads to deletion of Products in the Category"
		links = ""
		links += link_to 'edit', action:'edit', id:category.id
		links += " | "
		links += link_to 'delete', category_path(category), :confirm=>"#{warning}
		Are You Sure You want to Continue ?",
								 method:'delete'
		return links
	end

	def category_new
		button_to 'Add Category', new_category_path, class:'btn btn-primary', method:'get'
	end
end
