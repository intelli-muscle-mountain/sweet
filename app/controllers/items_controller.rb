class ItemsController < ApplicationController
	before_action :authenticate_customer!, except: [:index,:show,:about,:top]
	before_action :current_customer, except: [:index,:show,:about]

def top
		@items = Item.joins(:genre).where(sale_status: true, genres:{genre_status: true}).page(params[:page]).reverse_order
		@genres = Genre.where(genre_status: true)
	end

	def index
		@genres = Genre.where(genre_status: true)
		if params[:category].present?
			@genre = @genres.find_by(genre_name: params[:category])
			@items = Item.where(genre_id: @genre.id, sale_status: true).page(params[:page]).per(8)
			items = Item.where(genre_id: @genre.id, sale_status: true)
			@items_quantity = items.length
			# @items = Item.page(params[:page]).per(8)
		else
			@items = Item.joins(:genre).where(sale_status: true, genres:{genre_status: true}).page(params[:page]).per(8)
			items = Item.joins(:genre).where(sale_status: true, genres:{genre_status: true})
			@items_quantity = items.length
			# @items = Item.page(params[:page]).per(8)
		end
	end

	def show
		@item = Item.find(params[:id])
		@cartitem = Cartitem.new
		@genres = Genre.where(genre_status: true)
		if @item.sale_status == false
			redirect_to root_path
		end
		if @item.genre.genre_status == false
			redirect_to root_path
		end
	end

end
