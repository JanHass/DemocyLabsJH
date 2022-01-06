class FellowshipsController < ApplicationController
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
    redirect_to fellowships_url, notice: 'Fellowship was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fellowship
      @fellowship = Fellowship.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def fellowship_params
      params.require(:fellowship).permit(:id, :name, :description, :created_at, :updated_at, :organization_id, :author_id, :responsible_id, :flags_count, :geozone_id, :community_id, :clear_name)
    end
end
