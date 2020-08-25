class ItemsController < ApplicationController
  before_action :items, only: [:show, :destroy]
  before_action :set_parents, only: [:new, :create, :edit]

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
  end

  def index
    @items = Item.all
    @item = Item.new()
    @item_images = @item.item_images.build
    @parents = Category.where(ancestry: nil)
  end

  def show
    @parents = Category.where(ancestry: nil)
  end

  def new
    @product = Product.new
    @product.images.new
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
end
