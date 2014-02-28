class ApplicationController < ActionController::Base
  protect_from_forgery
  def after_sign_in_path_for(resource)
  	if current_user.user_detail
			if current_user.user_detail.first_name.nil?
				return users_edit_profile_path
			else
				return users_profile_path
			end
		else
			UserDetail.create!(user_id:current_user.id)
			return users_edit_profile_path
		end
  end

  def is_admin
  	(current_user.user_role == 101) ? true : (redirect_to unauthorized_index_path)
  end

  def is_active_user
  	(current_user.status == true) ? true : 	(redirect_to unauthorized_profile_path)
  end
end
