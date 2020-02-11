class CartitemsController < ApplicationController

	def index
		@cartitems = Cartitem.where(customer_id: current_customer.id)
	end

	def create
		cartitem = Cartitem.new(cartitem_params)
		cartitem.customer_id = current_customer.id
     if cartitem.save
     	redirect_to cartitems_path
     else
     	cartitems = Cartitem.all
     	render "items/show"
 		end
	end

	def update
	end

	def destroy
	end

	def destroy_all
		redirect_to
	end

	private
	def cartitem_params
		params.require(:cartitem).permit(:item_id,:customer_id,:quantity)
	end

end

