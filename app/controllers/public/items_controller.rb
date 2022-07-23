class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    if @item.is_active == true
      @status = "販売中"
    else
      @status = "販売停止中"
    end

    @add_cart = CartItem.new
  end
end
