class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production? 

  private
  
  def production?
    Rails.env.production?
  end
  
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  def card_index()

    # 初期化
    carddata = []

    cards = Credit.all()
    # user連携時にコメントを外すこと
    # cards = Credit.find_by(user_id: current_user.id)
    if cards == nil
      return;
    end

    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]

    cards.each do |card|
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

      carddata_i = {id: id,last: last, brand: brand, logo: brand_logo, exp_month: exp_month, exp_year: exp_year}
      carddata << carddata_i

    end

    return carddata

  end

end
