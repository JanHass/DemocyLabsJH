class AccountController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account

  load_and_authorize_resource class: "User"

  def show
    @fellowships = Fellowship.all 
  end

  

  def update

    if @account.update(account_params)
      redirect_to account_path, notice: t("flash.actions.save_changes.notice")
    else
      @account.errors.messages.delete(:organization)
      render :show
    end
  end

  def purgeavatar
    @user = current_user
    @user.avatar.purge
    redirect_to account_path, notice: t("flash.actions.save_changes.notice")
  end


  private

    def set_account
      @account = current_user
    end

    

    def account_params
      attributes = if @account.organization?
                     [:phone_number, :email_on_comment, :email_on_comment_reply, :newsletter,
                      organization_attributes: [:name, :responsible_name]]
                   else
                     [:username, :first_name, :last_name, :image, :avatar, :phone_number, :gender, :date_of_birth, 
                      :street, :housenumber, :postal_code, :city, :state, :country, 
                      :public_activity, :public_interests, :email_on_comment,

                      :email_on_comment_reply, :email_on_direct_message, :email_digest, :newsletter,
                      :official_position_badge, :recommended_debates, :recommended_proposals,
                      :public_profile_show_full_name, :public_profile_show_phone_number, :public_profile_show_gender, 
                      :public_profile_show_date_of_birth, :public_profile_show_address, :public_profile_show_state, 
                      :public_profile_show_city, :public_profile_show_country
                     ]
                   end
      params.require(:account).permit(*attributes)
    end
end
