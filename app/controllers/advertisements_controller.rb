class AdvertisementsController < ApplicationController
	helper_method :sort_column, :sort_direction
	before_filter :authenticate_user!, :except => [:index,  :search]

	def index
		@advertisements = Advertisement.all.paginate(page: params[:page], :per_page => 8)
		#@advertisements = @advertisements.order(sort_column + " " + sort_direction)
	end
	
	def index_of_user
		@advertisements = current_user.advertisements.all
	end
	
	def show
		@advertisement = Advertisement.find(params[:id])
	end
	
	def search
		currency = (params[:currencys])
		type = (params[:types])
		region = (params[:regions])
		@advertisements = Advertisement.where("currency= ? AND typec = ?  AND region = ?", currency, type, region)
	end
	
	def new 
		@advertisement = Advertisement.new
	end
	
	def create
		@advertisement = current_user.advertisements.build(advertisement_params)
		@advertisement.save
		if @advertisement.errors.empty?
			flash[:success] = "Added a new advertisement!"
			redirect_to adv_of_user_path
		else
			render "new"
		end
	end
	
	def edit
		@advertisement = Advertisement.find(params[:id])
	end
	
	def update
		@advertisement = Advertisement.find(params[:id])
		@advertisement.update_attributes(params[:advertisement])
		if @advertisement.errors.empty?
			redirect_to adv_of_user_path
		else
			render "edit"
		end
	end
	
	def destroy
		@advertisement = Advertisement.find(params[:id])
		@advertisement.destroy
		redirect_to advertisements_path
	end
	
	def sort_column
		Advertisement.column_names.include?(params[:sort]) ? params[:sort] : "sum"
	 end
	  
	 def sort_direction
		%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	 end
	
	private

    def advertisement_params
		params.require(:advertisement).permit(:typec, :currency, :course, :sum, :region, :tel)
    end
	
	def is_admin
		if current_user.username != "Admin"
			redirect_to root_url
		end
    end

end
