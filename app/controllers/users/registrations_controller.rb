# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  before_action :redirect_no_session , only: [:new_streets, :create_streets]

  def new
    @parents = Category.where(ancestry: nil)
    @user = User.new
    
  end

  def create
    @parents = Category.where(ancestry: nil)
    @user = User.new(user_params)
    @user.password_confirmation = user_params[:password_confirmation]
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      @user.Birthday = nil
      render :new and return
    end

    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @streets = @user.build_street
    render :new_streets
  end

  def new_streets
    
  end

  def create_streets

    begin
      @user = User.new(session["devise.regist_data"]["user"])
      @streets = Street.new(street_params)
      unless @streets.valid?
        flash.now[:alert] = @streets.errors.full_messages
        @streets = @user.build_street
        render :new_streets and return
      end
      @user.build_street(@streets.attributes)
      @user.save      
    rescue => exception
      flash.now[:alert] = exception
      @streets = @user.build_street
      render :new_streets and return
    end

    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)

  end

  private

  def user_params
    params.require(:user).permit(:nick_name,:email,:password, :password_confirmation,:firstname,:surname,:firstname_kana,:surname_kana,:Birthday)
  end

  def street_params
    params.require(:street).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number)
  end

  def redirect_no_session
    redirect_to root_path if session["devise.regist_data"].blank?
  end

end
