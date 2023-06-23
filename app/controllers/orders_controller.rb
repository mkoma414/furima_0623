class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :contributor_confirmation

  def index
    gon.public_key = 'pk_test_48674bfea9795c1ee9fd1b2f'
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      Payjp.api_key = "sk_test_a1548c7bf2226b396bfdbc75"
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
      @order_address.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def contributor_confirmation
    redirect_to root_path if @item.user_id == current_user.id || !@item.order.nil?
  end

  # def pay_item
  #   Payjp.api_key = "sk_test_a1548c7bf2226b396bfdbc75"  # PAY.JPテスト秘密鍵
  #   Payjp::Charge.create(
  #     amount: @item.price,  # 商品の値段
  #     card: order_params[:token],    # カードトークン
  #     currency: 'jpy'                 # 通貨の種類（日本円）
  #   )
  # end
end
