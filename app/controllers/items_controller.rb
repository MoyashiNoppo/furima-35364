class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    if @item.user != current_user
      redirect_to root_path
    end
  end

  def update
    @item = Item.find(params[:id])
      if @item.update(item_params)
        redirect_to item_path
      else
        render :edit
      end
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, 
      :shipping_charge_id, :ship_from_area_id, :days_to_ship_id, :price).merge(user_id: current_user.id)
  end

  def ensure_user
    @items = current_user
  end
  
end
