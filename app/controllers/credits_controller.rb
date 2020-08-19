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

      carddata = {last: last, brand: brand, logo: brand_logo, exp_month: exp_month, exp_year: exp_year}
      @carddata << carddata
      
    end

  end
  
  def new

  end

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

  private
  #ストロングパラメータ(items)
  def credit_params
    params.permit(:payjp_token)
    # user連携時にコメントを外すこと
    # params.permit(:payjp_token).merge(user_id: current_user.id)
  end
  
end
