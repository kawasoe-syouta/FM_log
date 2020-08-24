class PurchasesController < ApplicationController
  def show
    @purchases = Purchase.all
    @carddata = card_index()
    @item = Item.find(params[:item_id])
  end

  def update

    # カードが選択されていない場合
    if card_params == nil
      return create_action_error("支払い方法を選択してください")
    end

    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
    @item = Item.find(params[:item_id])

    # 出品中以外は購入不可
    if @item.phase_id != 1
      redirect_to item_path(@item.id), alert: "購入済みです"
    else
      @item.with_lock do
        @card = Credit.find_by(id: card_params[:card_id])

        # 支払い処理
        begin
          charge = Payjp::Charge.create(
            amount: @item.price,
            customer: Payjp::Customer.retrieve(@card.card_customer),
            currency: 'jpy'
          )
        rescue => exception
          return create_action_error(exception)
        end

        # 発送待ちに変更
        @item.update(phase_id: 3)
      end
    end

  end

  private

  def card_params
    unless params[:item] == nil
      return params.require(:item).permit(:card_id)
    else
      return nil
    end
  end

  def create_action_error(alert)
    @purchases = Purchase.all
    @carddata = card_index()
    @item = Item.find(params[:item_id])
    return render :show, alert: alert
  end

end
