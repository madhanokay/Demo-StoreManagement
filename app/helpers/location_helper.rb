module LocationHelper
	def location_link(location)
		warning = "Deleting the Location leads to deletion of Products in the Location"
		links = ""
		links += link_to 'edit', action:'edit', id:location.id
		links += " | "
		links += link_to 'delete', location_path(location), :confirm=>"#{warning}
		Are You Sure You want to Continue?", method:'delete'
		return links
	end

	def location_new
		button_to 'Add Location', new_location_path, class:'btn btn-primary', method:'get'
	end
end
