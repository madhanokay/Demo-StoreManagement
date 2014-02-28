namespace :admin do
	desc "Add a admin user."
	task :create => :environment do
		admin= User.new

		print "Admin email: "
		inp=STDIN.gets.strip
		admin.email=inp unless inp.blank?

		print "Admin password: "
		inp=STDIN.gets.strip
		admin.password=inp unless inp.blank?
		admin.password_confirmation=inp unless inp.blank?
		admin.skip_confirmation!
		admin.user_role = 101
		admin.status = true

		if User.find_by_user_role(101)
			puts "Admin already exists"
		else
			if admin.save
				UserDetail.create!(:user_id => admin.id)
				puts "added admin user"
			else
				puts "failed to add admin"
				puts admin.errors.full_messages.to_s
			end
		end
	end
end

