class LocationController < ApplicationController
	before_filter :authenticate_user!
	before_filter :is_admin

  def index
    @location = Location.all
  end

  def new
  	@location = Location.new
  end

  def create
  	@location = Location.new(params[:location])
		if @location.save
			flash[:notice] = "Successfully created..."
			redirect_to location_index_path
		else
			flash[:error] = @location.errors.full_messages.to_sentence
			render 'new'
  	end
  end

  def edit
    @location = Location.find(params[:id])
  end

	def update
		@location = Location.find(params[:location][:id])
		if @location.update_attributes(params[:location])
			flash[:notice] = "Successfully Updated..."
			redirect_to location_index_path
		else
			flash[:error] = @location.errors.full_messages.to_sentence
			render 'edit'
		end
	end

  def destroy
    @location = Location.find(params[:id])
    if @location.destroy
    	flash[:notice] = "Successfully Deleted..."
    else
    	flash[:error] = @location.errors.full_messages.to_sentence
    end
    redirect_to location_index_path
  end
end
