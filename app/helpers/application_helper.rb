module ApplicationHelper
	def is_admin
  	(current_user.user_role == 101)? true : false
  end
end
