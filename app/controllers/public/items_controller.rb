class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @item_all = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
