class SellsController < ApplicationController

  def index
    @item = Item.new()
  end

  def create
    #カテゴリーの取得
    category_data = Category.find_by(id: params[:item][:category])
    #フォームの取得(カテゴリ、phase:出品中 追加)
    @item = Item.new(params_int(item_params).merge(category: category_data, phase_id: 1))
    binding.pry
    if @item.save
      respond_to do |format|
        #出品完了(出品完了ページに飛ばす事)
        format.html {redirect_to sells_path, notice: '出品完了'}
      end
    else
      redirect_to sells_path, alert: '出品エラー'
    end
  end

  private
  
  #ストロングパラメータ
  def item_params
    params.require(:item).permit(:name, :item_detail, :status_id, :delivery_days, :delivery_to_pay_id, :price)
  end

  #数値に変換可能な文字列を数値に変換する
  def integer_string?(str)
    Integer(str)
    true
  rescue ArgumentError
    false
  end

  #paramsの内容を数値に変換
  def params_int(model_params)
    model_params.each do |key,value|
      if integer_string?(value)
        model_params[key]=value.to_i
      end
    end
    return model_params
  end

end
