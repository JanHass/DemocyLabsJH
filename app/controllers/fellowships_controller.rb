class FellowshipsController < ApplicationController
  include FeatureFlags 
  

  load_and_authorize_resource
  

  before_action :set_fellowship, only: [:show, :edit, :update, :destroy]

  @show_join_button = true

  # GET /fellowships
  def index
    @fellowships = Fellowship.all
  end

  # GET /fellowships/1
  def show
  end

  # GET /fellowships/new
  def new
    @fellowship = Fellowship.new
  end

  # GET /fellowships/1/edit
  def edit
  end

  # POST /fellowships
  def create
    @fellowship = Fellowship.new(fellowship_params)

    # New Group --> Current user add to Group with Adminstatus
    if @fellowship.save
      @n = @fellowship.fellowship_users.build(:user_id => current_user.id, :is_fellowship_administrator => true, :is_fellowship_owner => true)
      @n.save
      
      redirect_to @fellowship, notice: t("activerecord.attributes.fellowship.create_success")
    else
      render :new
    end
  end

  # PATCH/PUT /fellowships/1
  def update
    if @fellowship.update(fellowship_params)
      
      redirect_to @fellowship, notice: t("activerecord.attributes.fellowship.update_success")
    else
      render :edit
    end
  end

  # DELETE /fellowships/1
  def destroy
    @fellowship.destroy
    redirect_to fellowships_url, notice: t("activerecord.attributes.fellowship.delete_success")
  end

  # Join a Group
  def join
    @fellowship = Fellowship.find(params[:id])

    #If Password to join is required
    if @fellowship.join_password_required?

      #If Group Password == User entered Passwort -> Join
      if params[:password] == @fellowship.join_password
        @m = @fellowship.fellowship_users.build(:user_id => current_user.id)

        respond_to do |format|
          if @m.save
            format.html { redirect_to(@fellowship, :notice => t("activerecord.attributes.fellowship.join_success")) }
          else
            format.html { redirect_to(@fellowship, :alert => t("activerecord.attributes.fellowship.join_error")) }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to(@fellowship, :alert => t("activerecord.attributes.fellowship.join_wrong_password")) }
        end
      end 
      

    #If NO Password to join is required
    else  
      @m = @fellowship.fellowship_users.build(:user_id => current_user.id)
      respond_to do |format|
        if @m.save
          format.html { redirect_to(@fellowship, :notice => t("activerecord.attributes.fellowship.join_success")) }
        else
          format.html { redirect_to(@fellowship, :notice => t("activerecord.attributes.fellowship.join_error")) }
        end
      end
    end
  end
  
  
  helper_method :join

  def changeuserrole
    @fellowship = Fellowship.find(params[:id])
    respond_to do |format|
      format.html { redirect_to(@fellowship, :alert => "Methode aufgerufen") }
    end 

  end

  def leave
    @fellowship = Fellowship.find(params[:id]) 
    @fellowship.fellowship_users.each do |fellowship_user|

      if ( current_user.id == fellowship_user.user_id && fellowship_user.fellowship_id == @fellowship.id )
        fellowship_user.destroy
        
        respond_to do |format|
          format.html { redirect_to(@fellowship, :alert => "Verlassen" ) }   
        end
      else
      
      end
    end  
  end

  def kick 
    @fellowship = Fellowship.find(params[:id])
    m = params[:fellowship_user_id]
    @fellowship_user = @fellowship.fellowship_users.find(m)

    @fellowship_user.destroy

    respond_to do |format|
      format.html { redirect_to(@fellowship, :alert => "User wurde entfernt") }
    end
  end


  def leavebak
    
    @fellowship_user = current_user.fellowship_users.find(params[:id])
    @fellowship_user.destroy
    flash[:notice] = "You left the Group."
    redirect_to @fellowship
       
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fellowship
      @fellowship = Fellowship.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def fellowship_params
      params.require(:fellowship).permit(:name, :email, :image, :description, :created_at, :updatet_at, :organization_id, 
      :user_id, :author_id, :responsible_id, :flags_count, :geozone_id, :community_id, :clear_name, :user_required_full_name, 
      :user_required_phone_number, :user_required_gender, :user_required_date_of_birth, :user_required_adress, :user_required_state, 
      :user_required_city, :user_required_country, :user_public_show_full_name, :user_public_show_phone_number, :user_public_show_gender, 
      :user_public_show_date_of_birth, :user_public_show_address, :user_public_show_state, :user_public_show_city, :user_public_show_country, 
      :admin_required_full_name, :admin_required_phone_number, :admin_required_gender, :admin_required_date_of_birth, :admin_required_address, 
      :admin_required_state, :admin_required_city, :admin_required_country, :admin_public_show_full_name, :admin_public_show_phone_number, 
      :admin_public_show_gender, :admin_public_show_date_of_birth, :admin_public_show_address, :admin_public_show_state, :admin_public_show_city, 
      :admin_public_show_country, :join_password_required, :join_password, :short_description)
    end
end
