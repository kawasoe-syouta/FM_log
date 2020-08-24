class CreditsController < ApplicationController
  require "payjp"

  # user連携時はshow
  def index
  # def show

    @carddata = card_index()

  end
  
  def new

  end

  #カード登録
  def create
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
    customer = Payjp::Customer.create(
      description: '顧客登録',
      card: params[:payjp_token]
    )
    @credit = Credit.new(card_default: customer.default_card ,card_customer: customer.id)
    if @credit.save
      redirect_to credits_path, notice: 'クレジットカード情報を登録しました'
    else
      redirect_to new_credit_path
    end
  end

  #カード削除
  def destroy

    @card = Credit.find_by(id: params[:id])
    # user連携時にコメントを外すこと
    # @card = Credit.find_by(id: params[:id], user_id: current_user.id)

    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]

    # カード情報から登録されている顧客情報を参照
    customer = Payjp::Customer.retrieve(@card.card_customer)
    cardinfo = customer.cards.retrieve(@card.card_default)

    # 情報を削除
    cardinfo.delete
    customer.delete
    if @card.delete
      redirect_to credits_path, notice: 'クレジットカード情報を削除しました'
    else
      redirect_to credits_path, alert: '削除が出来ませんでした'
    end

  end

  private
  #ストロングパラメータ(items)
  def credit_params
    params.permit(:payjp_token)
    # user連携時にコメントを外すこと
    # params.permit(:payjp_token).merge(user_id: current_user.id)
  end
  
end
