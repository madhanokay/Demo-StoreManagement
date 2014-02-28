class Notification < ActiveRecord::Base
  attr_accessible :description, :status, :user_id, :reply_content,:from_user_id,
                   :subject, :read_status, :delete_status
  scope :of_current_user, lambda {|user| where(:user_id=>user.id)}
  belongs_to :user
  belongs_to :sent, :foreign_key=>:from_user_id,:class_name=>"User"
  default_scope order('created_at DESC')
  validates_presence_of :subject, :description

  def from
  	(User.find self.from_user_id).user_detail.full_name
  end

  def self.admin_id
    user = User.find_by_user_role(101)
    return user.id
  end

  def color_display_row
    if self.read_status == true
      color = "#E8E8E8"
    else
      color = "#FFFFFF"
    end
    return color
  end

  def self.approve_cart_success(cart)
    Notification.create!(user_id:cart.user_id,
                          subject:"Cart Approved",
                          description:"Your cart is Succesfully approved by the
                          admin, Please check the report for further details",
                          from_user_id:admin_id)

  end

  def self.approve_item(item)
    Notification.create!(user_id:item.user_id,
                          subject:"Item Approved",
                          description:"Your Item in the cart id #{item.cart_id}
                          has been approved by the admin",
                          from_user_id:admin_id)

  end

  def self.delete_cart(cart)
    Notification.create!(user_id:cart.user_id,
                          subject:"Cart Deleted",
                          description:"Your cart request has been deleted by
                          the admin, Please contact the  Admin for further queries",
                          from_user_id:admin_id)
  end

  def self.return_item(record)
    Notification.create!(user_id:record.user_id,
            subject:"Item Recieved",
            description:"#{record.product.name} Recieved Succesfully",
            from_user_id:admin_id)
  end

  def self.edit_request(item)
    Notification.create!(user_id:item.user_id,
      subject:"Edit Request",
      description:"The item
      #{item.product.name} has been updated by the admin, please check the report
      for more details ", from_user_id:admin_id)
  end

  def self.move_to_que(cart)
    Notification.create!(user_id:cart.user_id,
                          subject:"Cart Moved to Que",
                          description:"Your cart has been moved to que",
                          from_user_id:admin_id)
  end
end
