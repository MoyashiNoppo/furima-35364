class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :item_chose, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show

  end

  def edit
    
  end

  def update
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

    def item_chose
      @item = Item.find(params[:id])
    end
    
    def correct_user
      if @item.user != current_user
        redirect_to root_path
      end
    end
  
end
