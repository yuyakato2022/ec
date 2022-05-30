class Admin::CustomersController < ApplicationController
  layout 'admin/application'
  def index
    @customers = Customer.all.page(params[:page]).per(6)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "#{@customer.full_name}さんの会員情報を更新しました"
      redirect_to admin_customer_path(@customer)
    else
      render "edit"
    end
  end


  def order_index
    @customer = Customer.find(params[:customer_id])
    if params[:status] == "ichiran"
      @orders = @customers.orders.page(params[:page]).per(10)
    elsif params[:status]
      @order_statuses = @customer.orders.where(status: params[:status])
      @orders = @order_statuses.page(params[:page]).per(10)
    else
      @orders = @customer.orders.page(params[:page]).per(10)
    end
  end
  private

  def customer_params
    params.require(:customer).permit(:is_deleted)
  end
end
