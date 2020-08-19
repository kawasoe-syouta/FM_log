class CreditsController < ApplicationController
  require "payjp"

  # user連携時はshow
  def index
  # def show

    # 初期化
    @carddata = []

    @cards = Credit.all()
    # user連携時にコメントを外すこと
    # @cards = Credit.find_by(user_id: current_user.id)
    if @cards == nil
      return;
    end

    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]

    @cards.each do |card|
      # カード情報から登録されている顧客情報を参照
      customer = Payjp::Customer.retrieve(card.card_customer)
      # カード情報を表示
      cardinfo = customer.cards.retrieve(card.card_default)
      # カードID
      id = card.id
      # 末尾4文字
      last = cardinfo.last4
      # カードブランド
      brand = cardinfo.brand
      case cardinfo.brand
      when "Visa" then
        brand_logo = "visa"
      when "MasterCard" then
        brand_logo = "mc"
      when "JCB" then
        brand_logo = "jcb"
      when "American Express" then
        brand_logo = "amex"
      when "Diners Club"
        brand_logo = "diners"
      when "Discover"
        brand_logo = "discover"
      end

      # 有効期限
      exp_month = cardinfo.exp_month.to_s
      exp_year = cardinfo.exp_year.to_s.slice(2,3)

      carddata = {id: id,last: last, brand: brand, logo: brand_logo, exp_month: exp_month, exp_year: exp_year}
      @carddata << carddata

    end

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
