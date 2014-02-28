class Category < ActiveRecord::Base
  attr_accessible :description, :name
  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name
  validates_format_of :name, :with=>/\A[a-z A-Z 0-9 .()-]*['?]*[a-z A-Z 0-9 .()-]+\z/
  has_many :products, :dependent=>:destroy
  has_many :damage_product_lists, :dependent=>:destroy
end
