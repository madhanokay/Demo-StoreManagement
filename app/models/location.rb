class Location < ActiveRecord::Base
  attr_accessible :location_description, :location_name
  validates_uniqueness_of :location_name, :case_sensitive => false
  validates_presence_of :location_name
  validates_format_of :location_name, :with=>/\A[a-z A-Z 0-9 .()-]*['?]*[a-z A-Z 0-9 .()-]+\z/
  has_many :products, :dependent=>:destroy
  has_many :damage_product_lists, :dependent=>:destroy
end
