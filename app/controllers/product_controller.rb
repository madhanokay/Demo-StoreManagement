class ProductController < ApplicationController
	before_filter :authenticate_user!
	before_filter :is_admin

	def index
    @category = Category.all
    @location = Location.all
    datas = Product.all
    datas.each do |data|
      color_set = data.bg_color_in_row(data.usage_status)
      sorting = data.sorting_products
    end
    @products = Product.order("sorting_value ASC")
	end

  def search_result
    @category = Category.all
    @location = Location.all
    @products = Product.search_for_product(params[:post], params[:loc],
                    params[:post][:category], params[:loc][:location])
  end

  def new
  	if Location.exists? && Category.exists?
  		@product = Product.new
  		@location = Location.all
  		@category = Category.all
  	else
  		flash[:error] = "There should be atleast one location and category to add Product "
  		redirect_to product_index_path
  	end
  end

  def create
	 	@product = Product.new(params[:product])
  	if @product.save
  		flash[:notice] = "Successfully created..."
  		redirect_to product_index_path
  	else
  		@location = Location.all
  		@category = Category.all
  		flash[:error] = @product.errors.full_messages.to_sentence
  		render 'new'
		end
	end

	def show
		@product = Product.find(params[:id])
	end

	def edit
		@location = Location.all
  	@category = Category.all
	 	@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:product][:id])
		if @product.update_attributes(params[:product])
			flash[:notice] = "Successfully Updated..."
			redirect_to product_index_path
		else
			@location = Location.all
  		@category = Category.all
			flash[:error] = @product.errors.full_messages.to_sentence
			render 'edit'
		end
	end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
    	flash[:notice] = "Successfully Deleted..."
    else
    	flash[:error] = @product.errors.full_messages.to_sentence
    end
    redirect_to product_index_path
  end

  def move_to_damage_list
    @product = Product.find(params[:id])
  end

  def move_to_damage

    @product = Product.find(params[:product][:id])
    quantity = params[:product][:quantity].to_i
    if @product.quantity == quantity
      flash[:notice] = "Cant Move the whole products to Damage list"
    else
      DamageProductList.create_damage_list_from_product(@product,quantity)
      new_quantity = @product.quantity - quantity
      if @product.update_attributes(:quantity => new_quantity)
        flash[:notice] = "#{quantity} has been moved to damage list"
      else
        flash[:error] = @product.errors.full_messages.to_sentence
      end
    end
    redirect_to product_index_path
  end
end
