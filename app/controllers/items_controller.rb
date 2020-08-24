class ItemsController < ApplicationController

  before_action :items, only: [:show, :destroy]
  before_action :set_parents, only: [:new, :create, :edit]
  def index
    @items = Item.all
  end
  

  def search
    respond_to do |format|
      format.html
      format.json do
        if params[:parent_id]
          @childrens = Category.find(params[:parent_id]).children
        elsif params[:children_id]
          @grandChilds = Category.find(params[:children_id]).children
        end
      end
    end
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
    @categories = Category.order(:id)
  end

  def index
    @items = Item.all
    @parents = Category.where(ancestry: nil)
  end
  

  def index
    @categories = Category.order(:id)
    @item = Item.new()
    @item_images = @item.item_images.build
  end

  def show
    @parents = Category.where(ancestry: nil)
<<<<<<< HEAD
  end
  
  def new
    @product = Product.new
    @product.images.new
    @item_images = @item.item_images.build
  end
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.new
  end
  def update
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    if @items.destroy
      redirect_to root_path
    else
      alert:"削除ができません"
    end
  end

  private
  def items
    @items = Item.find(params[:id])
  end
  def edit
    
  end

  private

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
      begin
        if integer_string?(value)
          model_params[key]=value.to_i
        end              
      rescue => exception
        # nothing
      end
    end
    return model_params
  end
  def edit
    @categories = Category.order(:id)
  end

  private

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
      begin
        if integer_string?(value)
          model_params[key]=value.to_i
        end              
      rescue => exception
        # nothing
      end
    end
    return model_params
  end
end
end
