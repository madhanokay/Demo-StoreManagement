class Product < ActiveRecord::Base
  attr_accessible :category_id, :location_id, :name, :price, :purchase_date,
  								:quantity, :trigger, :image, :value, :priority,:sorting_value
  has_attached_file :image
	belongs_to :location
	belongs_to :category
	has_many :items
  has_many :records, :dependent=>:destroy
  has_many :damage_product_lists, :dependent=>:destroy

	validates_uniqueness_of :name, :case_sensitive => false
	validates_presence_of :name, :quantity, :price, :trigger, :purchase_date
  validates_format_of :name, :with=>/\A[a-z A-Z 0-9 .()-]*\z/
  validates_numericality_of :trigger,
  													:only_integer => true, :greater_than => 0
  validates_numericality_of :quantity, :only_integer=>true, :greater_than=>0,
                            :on => :create
  validates_numericality_of :quantity, :only_integer=>true, :greater_than_or_equal_to=>0,
                            :on => :update
	validates_numericality_of :price, :greater_than => 0
	validates :price, :length => {maximum:8}
	validates_format_of :purchase_date, with:/\A\d{4}\-\d{2}\-\d{2}\z/
	validate :future_dates

  delegate :name, :to => :category, :prefix => true
  delegate :location_name, :to => :location, :prefix=>true

	def future_dates
	 if self.purchase_date.to_date > Date.today
	 		self.errors[:base] << "Date is Invalid"
	 	end
	end

	def usage_status
    ratio = self.quantity.to_f/self.trigger.to_f
    status = (self.trigger + (self.trigger/ratio)) + 1
    return status.round(3)
  end

  def bg_color_in_row(usage_status)
    if self.quantity > usage_status
      color = "#A9F5A9" #green
      value = 3
    elsif usage_status > self.trigger && self.quantity > self.trigger
      color = "#EDFF6F" #yellow
      value = 2
    elsif usage_status > self.quantity
      color = "#FF7166" #red
      value = 1
    end
    self.update_attributes!(:value => value)
    return color
  end

  def sorting_products
    if self.value == 1 && priority == true
      sort_order = 1
    elsif self.value == 1
      sort_order = 2
    elsif self.value == 2 && priority == true
      sort_order = 3
    elsif self.value == 2
      sort_order = 4
    elsif self.value == 3 && priority == true
      sort_order = 5
    else
      sort_order = 6
    end
    self.update_attributes!(:sorting_value=>sort_order)
  end

  def self.search_for_product(params_post, params_loc, params_category_id, params_location_id)
    if params_post.blank? && params_loc.blank?
      return Product.all
    elsif params_post || params_loc
      conditions ={}
      category_id = params_category_id unless params_category_id.blank?
      location_id = params_location_id unless params_location_id.blank?
      if category_id && location_id
        conditions[:category_id] = params_category_id
        conditions[:location_id] = params_location_id
      elsif category_id
        conditions[:category_id] = params_category_id
      elsif location_id
        conditions[:location_id] = params_location_id
      end
      return Product.find(:all, :conditions=> conditions)
    else
      return Product.all
    end
  end
end


