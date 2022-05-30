class Public::ReviewsController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    @review.item_id = @item.id
    @review.save
    render :index
  end

  def destroy
    @item = Item.find(params[:item_id])
    Review.find(params[:id]).destroy
    render :index
  end

  private

  def review_params
    params.require(:review).permit(:star, :title, :body)
  end

end
