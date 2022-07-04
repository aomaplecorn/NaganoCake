class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @item_all = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def search
    @items = Item.search(params[:keyword])
    @search_items = @items.page(params[:page]).per(8)
    @keyword = params[:keyword]
    render :search
  end

end
