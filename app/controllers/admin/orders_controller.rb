class Admin::OrdersController < ApplicationController
  def index
    # @customer = Customer.find(params[:order][:customer_id])
    @orders = Order.page(params[:page])
    # @order = Order.find_by(params[:customer_id])


  end

  def show
    @order = Order.find(params[:id])
    @total_price = @order.total_payment - @order.shipping_cost
    @order_details = OrderDetail.all
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order.id)
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
end
