class CategoryController < ApplicationController
	before_filter :authenticate_user!
	before_filter :is_admin

  def index
    @category = Category.all
  end

  def new
  	@category = Category.new
  end

  def create
  	@category = Category.new(params[:category])
		if @category.save
			flash[:notice] = "Successfully created..."
			redirect_to category_index_path
		else
			flash[:error] = @category.errors.full_messages.to_sentence
			render 'new'
  	end
  end

  def edit
    @category = Category.find(params[:id])
  end

	def update
		@category = Category.find(params[:category][:id])
		if @category.update_attributes(params[:category])
			flash[:notice] = "Successfully Updated..."
			redirect_to category_index_path
		else
			flash[:error] = @category.errors.full_messages.to_sentence
			render 'edit'
		end
	end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
    	flash[:notice] = "Successfully Deleted..."
    else
    	flash[:error] = @category.errors.full_messages.to_sentence
    end
    redirect_to category_index_path
  end
end
