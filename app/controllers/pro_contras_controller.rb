class ProContrasController < ApplicationController
  before_action :set_pro_contra, only: [:show, :edit, :update, :destroy]

  skip_authorization_check

  # GET /pro_contras
  def index
    @pro_contras = ProContra.all
  end

  # GET /pro_contras/1
  def show
  
  end

  # GET /pro_contras/new
  def new
    @pro_contra = ProContra.new
  end

  # GET /pro_contras/1/edit
  def edit
  end

  # POST /pro_contras
  def create
    
        
      # Get Article comment is attached to

      @debate = Debate.find(params[:debate_id])

      # Create and save comment

      @pro_contra = @debate.pro_contras.create(pro_contra_params)

      # Go to the article this comment is associated with

      redirect_to debate_path(@debate)
  

  
  #def pro_contra_params
   #   params.require(:pro_contra).permit(:user_id, :body, )
  #end
    #@pro_contra = ProContra.new(pro_contra_params)

    #if @pro_contra.save
      #redirect_to @pro_contra, notice: 'Pro contra was successfully created.'
    #else
      #render :new
    #end
  end

  # PATCH/PUT /pro_contras/1
  def update
    if @pro_contra.update(pro_contra_params)
      redirect_to @pro_contra, notice: 'Pro contra was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pro_contras/1
  def destroy
    @pro_contra.destroy
    redirect_to pro_contras_url, notice: 'Pro contra was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pro_contra
      @pro_contra = ProContra.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pro_contra_params
      params.require(:pro_contra).permit(:tag, :body, :sources, :email, :rating, :likes, :dislikes, :reported, :move, :pc, :user_id, :debate_id, :proposal_id, :poll_id, :vote_id, :fellowship_id)
    end
end
