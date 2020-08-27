class ItemsController < ApplicationController

  before_action :items, only: [:show, :destroy, :show_image]
  before_action :set_parents, only: [:new, :create, :edit,:update]

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
  
  def edit
    @item = Item.find(params[:id])
    @item_images = @item.item_images
  end
  def update
    @item = Item.find(params[:id])
    @item_images = @item.item_images
    category_data = Category.find_by(id: params[:item][:category])
    # この二つがない時はupdateしない
    if @item_images.exists? || params[:item].include?("item_images_attributes")
      if @item.valid?
        update_image = item_images_params.values
        before_image = @item_images.ids
        before_image.each do |i|
          ItemImage.find(i).destroy unless update_image.find {|v| v[:id] == "#{i}"}
        end
        if @item.update(params_int(update_item_params).merge(category: category_data))
          flash[:notice] = '編集が完了しました'
          redirect_to items_path(@item)
        else
          flash[:alert] = '未入力項目があります'
          render :edit
        end 
      else
        flash[:alert] = '未入力項目があります'
        render :edit
      end
    else
      flash[:alert] = '未入力項目があります'
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

  def item_params
    params.require(:item).permit(:name, :item_detail, :status_id, :delivery_day_id, :delivery_area_id, :delivery_to_pay_id, :price, item_images_attributes: [:image]).merge(sell_user_id: current_user.id)
  end

  def update_item_params
    params.require(:item).permit(:name, :item_detail, :status_id, :delivery_day_id, :delivery_area_id, :delivery_to_pay_id, :price, item_images_attributes: [:image, :id]).merge(sell_user_id: current_user.id)
  end

  def item_images_params
    params.require(:item).require(:item_images_attributes)
  end
end
