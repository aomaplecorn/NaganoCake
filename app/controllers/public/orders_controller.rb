class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
  end

  def confirm
    # カートアイテムが空かどうか判定　カートアイテムが　有る　場合の処理
    if current_customer.cart_items != nil
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      # confirm画面の金額表示を用意
      @cart_items = current_customer.cart_items
      # カート内の合計金額を格納
      @total_price = @cart_items.inject(0) { |total, item| total + item.subtotal }
      # 送料（shipping_cost）を格納
      @order.shipping_cost = 800
      # カート内の合計金額＋送料　を　請求金額(total_payment)へ格納
      @order.total_payment = @total_price + @order.shipping_cost

      # 以下、view/new　で定義した address_number（１）＝「ご自身の住所」　の処理
      if params[:order][:address_number] == "1"
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.last_name + current_customer.first_name

      # 以下、view/new　で定義した address_number（２）＝「登録済住所から選択」　の処理
      elsif params[:order][:address_number] == "2"
        # 選択した住所を　@address　へ格納し、@orderへ渡す
        @address = Address.find(params[:order][:address_id])
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name

      # 以下、view/new　で定義した address_number（３）＝「新しいお届け先」　の処理
      elsif params[:order][:address_number] == "3"

      else
        render :new
      end
    # カートアイテムが空かどうか判定　カートアイテムが　無い 場合の処理
    else
      redirect_to public_cart_items_path
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id

    if @order.save
  # ユーザーのカートアイテムを変数（cart_item）へ格納
      cart_items = current_customer.cart_items.all
  # カート情報をもとに、注文詳細（OrderDetail）を作成し保存
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.price = cart_item.item.add_tax_price
        order_detail.amount = cart_item.amount
        order_detail.save
      end
      cart_items.destroy_all
      redirect_to public_complete_path
    else
      render :new
    end
  end

  # 注文履歴一覧
  def index
    @orders = current_customer.orders
  end

  # 注文履歴詳細
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.all
  # 商品合計を逆算
    @total_price = @order.total_payment - @order.shipping_cost

  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end




