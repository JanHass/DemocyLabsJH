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

    if @fellowship.save
      redirect_to @fellowship, notice: 'Fellowship was successfully created.'
    else
      render :new
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
    @fellowship.destroy
    redirect_to fellowships_url, notice: 'Fellowship was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fellowship
      @fellowship = Fellowship.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def fellowship_params
      params.require(:fellowship).permit(:name, :email, :image, :description, :created_at, :updatet_at, :organization_id, :user_id, :author_id, :responsible_id, :flags_count, :geozone_id, :community_id, :clear_name, :user_required_full_name, :user_required_phone_number, :user_required_gender, :user_required_date_of_birth, :user_required_adress, :user_required_state, :user_required_city, :user_required_country, :user_public_show_full_name, :user_public_show_phone_number, :user_public_show_gender, :user_public_show_date_of_birth, :user_public_show_address, :user_public_show_state, :user_public_show_city, :user_public_show_country, :admin_required_full_name, :admin_required_phone_number, :admin_required_gender, :admin_required_date_of_birth, :admin_required_address, :admin_required_state, :admin_required_city, :admin_required_country, :admin_public_show_full_name, :admin_public_show_phone_number, :admin_public_show_gender, :admin_public_show_date_of_birth, :admin_public_show_address, :admin_public_show_state, :admin_public_show_city, :admin_public_show_country)
    end
end
