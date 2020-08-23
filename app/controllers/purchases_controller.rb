class PurchasesController < ApplicationController
  def show
    @purchases = Purchase.all
    @carddata = card_index()
    @item = Item.find(params[:item_id])
  end

  def update
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
    @item = Item.find(params[:item_id])

    # 出品中以外は購入不可
    if @item.phase_id != 1
      redirect_to item_path(@item.id), alert: "購入済みです"
    else
      @item.with_lock do
        @card = Credit.find_by(id: card_params[:card_id])
        charge = Payjp::Charge.create(
          amount: @item.price,
          customer: Payjp::Customer.retrieve(@card.card_customer),
          currency: 'jpy'
        )
        # 発送待ちに変更
        @item.update(phase_id: 3)
      end
    end

  end

  private

  def card_params
    params.require(:item).permit(:card_id)
  end

end
