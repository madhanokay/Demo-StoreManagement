class Cart < ActiveRecord::Base
  attr_accessible :total_price, :user_id, :status, :move_to_que
  validates :user_id, :presence=>true
  scope :of_current_user, lambda { |user| where(:user_id=> user.id,
                                    :status=>false) }
  has_many :items, :dependent=>:destroy
  belongs_to :user

  def add_product_to_item(product_id)
    current_item = items.find_by_product_id(product_id)
		if current_item
			current_item.quantity += 1
		else
			current_item = items.build(:product_id => product_id,
                                  :user_id=>self.user_id)
		end
			current_item
  end

  def whole_price
		items.to_a.sum {|item| item.total}
	end
end
