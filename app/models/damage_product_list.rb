class DamageProductList < ActiveRecord::Base
  attr_accessible :category_id, :location_id, :product_id, :quantity
  belongs_to :product
  belongs_to :category
  belongs_to :location
  def self.create_damage_list(record)
  	DamageProductList.create!(product_id:record.product_id,
  														location_id:record.product.category_id,
  														category_id:record.product.location_id,
  														quantity:record.quantity)
  end

  def self.create_damage_list_with_quantity(record,quantity)
  	DamageProductList.create!(product_id:record.product_id,
  														location_id:record.product.category_id,
  														category_id:record.product.location_id,
  														quantity:quantity)
  end

  def self.create_damage_list_from_product(product,quantity)
    DamageProductList.create!(product_id:product.id,
                            location_id:product.location_id,
                            category_id:product.category_id,
                            quantity:quantity)

  end
end
