class ProductsController < ApplicationController
  before_action :ensure_current_user, only: [:edit, :update]
  before_action :set_product, only: [:new, :create, :edit, :update]

  def index
    @parents = Category.where(ancestry: nil)
    @products = Product.all
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
  end
  def update
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, images_attributes: [:src, :_destroy, :id]).merge(user_id: current_user.id)
  end
  def ensure_current_user
    product = Product.find(params[:id])
    if product.user_id != current_user.id
      redirect_to action: :index
    end
  end
  def set_product
    @product = Product.find(params[:id])
  end
end
