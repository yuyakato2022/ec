class Admin::OrdersController < ApplicationController
  layout 'admin/application'
  def show
    @order = Order.find(params[:id])
    @customer = Customer.find_by(params[order_id: @order.id])
    @order_detail = @order.order_details.find_by(order_id: @order.id)
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params)
    if @order.status == "confirm"
      @order_details.update_all('production_status = 1')
    end
    flash[:notice] = "注文ステータスを更新しました"
    redirect_to request.referer
  end

  private

    def order_params
      params.require(:order).permit(:status)
    end
end
