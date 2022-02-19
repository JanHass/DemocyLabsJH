class FellowshipsController < ApplicationController
  include FeatureFlags 
  

  load_and_authorize_resource
  

  before_action :set_fellowship, only: [:show, :edit, :update, :destroy]

  # GET /fellowships
  def index
    @fellowships = Fellowship.all
  end

  # GET /fellowships/1
  def show
    @fellowship = Fellowship.find(params[:id])
    
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
    @fellowship = current_user.build_owned_fellowship(fellowship_params)
    @fellowship.members << current_user

    if @fellowship.save
        redirect_to current_user
    else
        redirect_to new_fellowship_path
    end
  end


  # PATCH/PUT /fellowships/1
  def update
    if @fellowship.update(fellowship_params)
      redirect_to @fellowship, notice: 'Fellowship was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /fellowships/1
  def destroy
    @fellowship = current_user.owned_fellowship.find(params[:id])
    flash[:alert] = "Are you sure you want to delete your fellowship? Your fellowship and all of its associations will be permanently deleted."
    @fellowship.destroy

    if @fellowship.destroy
       redirect_to current_user
       flash[:notice] = "You deleted the fellowship."
    else
        redirect_to current_user
        #set up error handler
        flash[:notice] = "Failed to delete fellowship."
    end
end

  # Join a Group
#  def join
 #   @fellowship = Fellowship.find(params[:id])
  #  @m = @fellowship.fellowship_users.build(:user_id => current_user.id)
   # respond_to do |format|
    #  if @m.save
     #   format.html { redirect_to(@fellowship, :notice => 'You have joined this group.') }
      #else
       # format.html { redirect_to(@fellowship, :notice => 'Join error.') }
    #  end
   # end
 # end
    
 # def leave
  #  @fellowship = Fellowship.find(params[:id]) 
   # @fellowship.fellowship_users.each do |fellowship_user|
#
 #     if ( current_user.id == fellowship_user.user_id && fellowship_user.fellowship_id == @fellowship.id )
  #      fellowship_user.destroy
   #     
    #    respond_to do |format|
     #     format.html { redirect_to(@fellowship, :alert => "Verlassen" ) }   
      #  end
     # else
           
        
    #  end
   # end  
 # end
 

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
      :admin_public_show_country, :zip_code)
    end
  
end
