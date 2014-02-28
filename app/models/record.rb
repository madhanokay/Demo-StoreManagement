class Record < ActiveRecord::Base
  attr_accessible :category_id, :product_id, :purchase_date, :quantity, :user_id,
  								:return_item_date, :return_status, :item_recieve_status, :delay_by,
  								:move_to_damage, :cart_id
  scope :of_current_user, lambda { |user| where(:user_id=> user.id) }

 belongs_to :category
 belongs_to :product
 belongs_to :user
 belongs_to :item

 delegate :name, :to => :product, :prefix => true

 def status
 	  if self.return_item_date.to_date > Date.today.to_date
 			item_status = "Under Usage "
 		elsif self.return_item_date.to_date < Date.today.to_date && self.return_status == false
 			item_status = "Delay "
 		elsif self.return_item_date.to_date == Date.today.to_date && self.return_status == false
 			item_status = "Item Not Recieved Yet"
 		elsif self.return_status == true && self.move_to_damage == false
 			item_status = " Recieved "
 		else
 		 	item_status = "Damaged"
 		end
 		if self.update_attributes(:item_recieve_status=> item_status)
 		else
 			self.errors[:base] << "unable to save the status"
 		end
  end

 def color
		if self.item_recieve_status == "Under Usage "
 			return "label"
 		elsif self.item_recieve_status == "Delay "
 			return "label label-important"
 		elsif self.item_recieve_status == "Item Not Recieved Yet"
 			return "label label-info"
 		elsif self.item_recieve_status == " Recieved "
 			return "label label-success"
 		else
 			return "label label-warning"
 		end
 	end

 	def self.approve_cart(item)
 		Record.create!(category_id:item.product.category_id,
 											product_id:item.product_id,
											quantity:item.quantity,
											user_id:item.user_id,
											purchase_date:Date.today,
											return_item_date:item.return_date,
											cart_id:item.cart_id)
 	end

 	def self.approve_item(item)
 		Record.create!(category_id:item.product.category_id,
 											product_id:item.product_id,
											quantity:item.quantity,
											user_id:item.user_id,
											purchase_date:Date.today,
											return_item_date:item.return_date,
											cart_id:item.cart_id)
 	end

 	def self.create_damage_record(record,quantity)
 		Record.create!(category_id:record.category_id,
	 									product_id:record.product_id,
	 									quantity:quantity,
	 									user_id:record.user_id,
	 									purchase_date:Date.today,
	 									return_item_date:Date.today,
	 									move_to_damage:true,
	 									return_status:true,
	 									item_recieve_status:'Damaged')
 	end

 	def delay_check
 		if self.return_item_date.to_date < Date.today.to_date && self.return_status == false
 			value = Date.today.to_date - self.return_item_date.to_date
 			self.update_attributes!(:delay_by=>value)
 			return self.delay_by
 		end
 	end

 	def delay_by_display
 		if self.delay_by
 			return self.delay_by.to_s + "days"
 		else
 			return "NA"
 		end
 	end
end
