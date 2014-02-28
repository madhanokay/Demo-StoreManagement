class UserDetail < ActiveRecord::Base
  attr_accessible :address, :contact_number, :first_name, :position,
  								 :second_name, :user_id, :image
  validates_presence_of :first_name, :second_name, :on =>:update
  validates_format_of :first_name, :second_name,:with=>/\A[a-z A-Z]*\z/
  validates_format_of :position, :with=>/\A[a-z A-Z 0-9 -.()]*\z/
  validates_format_of :contact_number, :with=>/\A[0-9]{10}\z/, :on =>:update
  belongs_to :user
  has_attached_file :image

  def full_name
  	self.first_name.to_s + ' ' + self.second_name.to_s
  end
end
