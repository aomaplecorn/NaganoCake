class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @cart_item = CartItem.new
    # 合計金額の表示
    @total_price = @cart_items.inject(0) { |total, item| total }
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    # カート内にある同じアイテムのレコードを取得し、既存のカートアイテム（existing_cart_item）へ格納
    @existing_cart_item = current_customer.cart_items.find_by(item_id: @cart_item.item_id)
    # カート内に同じアイテムがない場合、レコードを新規作成する
    if @existing_cart_item == nil
      @cart_item.save
      redirect_to public_cart_items_path
    # カート内に同じアイテムがある場合、レコードの"数量"を更新する
    else
      @existing_cart_item.amount += @cart_item.amount
      @existing_cart_item.save
      redirect_to public_cart_items_path
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to public_cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
