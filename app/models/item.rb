class Item < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :quantity, :total, :user_id, :status,
  								:return_date, :purchasing_date
  scope :of_current_cart, lambda { |cart| where(:cart_id=> cart) }
  belongs_to :cart
  belongs_to :product
  belongs_to :user
  validates_presence_of :return_date, :purchasing_date
  validates_format_of :return_date, with:/\A\d{4}\-\d{2}\-\d{2}\z/
	validate :past_dates
	validate :past_purchasing_date

	delegate :name, :price, :quantity, :to => :product, :prefix => true

  def past_dates
	 if self.return_date && self.return_date.to_date < self.purchasing_date.to_date
	 		self.errors[:base] << "Date is Invalid"
	 	end
	end

	def past_purchasing_date
		if self.purchasing_date && self.purchasing_date.to_date < Date.today.to_date
	 		self.errors[:base] << "Date is Invalid"
	 	end
	end

	def approve_link
		if self.purchasing_date == Date.today.to_date
			return true
		else
			return false
		end
	end

	def date_status
		(self.return_date.to_date - self.purchasing_date.to_date).to_i
	end

	def item_status(product_id)
  	cart = Cart.where(:status =>true)
  	items = []
  	total_quantity_requested = []
  	cart.map{|c| items += c.items.where(:product_id=>product_id)}
    items.map{|qty| total_quantity_requested << qty.quantity}
    return total_quantity_requested.sum
	end

	def item_available(total_quantity, product_quantity)
		quantity = total_quantity - product_quantity
		if quantity > 0
			return "#{quantity} available out of #{total_quantity}"
		else
			return "Item is on Demand"
		end
	end
end
