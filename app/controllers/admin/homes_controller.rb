class Admin::HomesController < ApplicationController
  layout 'admin/application'
  def top
    if params[:status] == "ichiran"
      @orders = Order.all.page(params[:page]).per(6)
    elsif params[:status]
      @order_statuses = Order.where(status: params[:status])
      @orders = @order_statuses.page(params[:page]).per(10)
    else
      @orders = Order.all.page(params[:page]).per(10)
    end
  end
  def order_status_params
    params.require(:order).permit(:status)
  end
end
