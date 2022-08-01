class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @post_item = Item.new
  end

  def create
    post_item = Item.new(item_params)
    post_item.save
    redirect_to admin_items_path

  end

  def show
    @post_item = Item.find(params[:id])

    if @post_item.is_active == true
      @status = "販売中"
    else
      @status = "販売停止中"
    end

  end

  def edit
    @post_item = Item.find(params[:id])

  end

  def update
    post_item = Item.find(params[:id])
    post_item.update(item_params)
    redirect_to admin_item_path
  end



  def item_params
     params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end



end
