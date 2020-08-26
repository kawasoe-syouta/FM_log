class ItemsController < ApplicationController

  before_action :items, only: [:show, :destroy, :show_image]
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
    @category = @items.category
    if @category.ancestry == nil
      @parent = @category
      @child = nil
      @grandchild = nil
    elsif @category.ancestry.include?("/") == false
      @parent = Category.find_by(id: @category.ancestry)
      @child = @category
      @grandchild = nil
    else
      @parent = Category.find_by(id: @category.ancestry.split("/")[0])
      @child = Category.find_by(id: @category.ancestry.split("/")[1])
      @grandchild = @category
    end
    @image = ItemImage.all
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
  
  def show_image
    @image = @items.item_images
    send_data @image[0].image.file.read, :type => 'image.content_type', :disposition => 'inline'
  end
  

  private
  def items
    @items = Item.find(params[:id])
  end
end
