# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end

    # streetビュー完成後に追加する
    # session["devise.regist_data"] = {user: @user.attributes}
    # session["devise.regist_data"][:user]["password"] = params[:user][:password]
    # @streets = @user.build_street
    # render :new_streets

    @user.save
    render :new_streets

  end

  # streetビュー完成後に追加する
  def new_streets

  end

  def create_streets
    
  end

  private

  def user_params
    params.require(:user).permit(:nick_name,:email,:password,:firstname,:surname,:firstname_kana,:surname_kana,:Birthday)
  end

end
