module AdminHelper
	def user_status(detail)
		status = User.find(detail.user_id).status
		status ? "Active" : "Inactive"
	end

	def user_link(detail)
		links = ""
		links += link_to 'view', action:'show_user', id:detail.user_id
		links += " | "
		links += link_to 'edit', action:'edit_user', id:detail.user_id
		links += " | "
		status = User.find(detail.user_id).status
		block_action = (status ? "Block" : "Unblock")
		links += link_to "#{block_action}", action:'block_user', id:detail.user_id, status:!status
		return links
	end
	def damage_list_action(list)
	  link_to 'Restore', action:'restore_damage', id:list.id
	end
end
