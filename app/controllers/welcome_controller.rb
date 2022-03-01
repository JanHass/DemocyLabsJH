class WelcomeController < ApplicationController
  include RemotelyTranslatable

  skip_authorization_check
  before_action :set_user_recommendations, only: :index, if: :current_user
  before_action :authenticate_user!, only: :welcome

  layout "devise", only: [:welcome, :verification]

  def search
    if params[:search].blank?
      if params[:selected_param] == "Groups"
        @results_fellowships = Fellowship.all
        @results_proposals = []
        @results_postal_codes = []
        #redirect_to user_path and return
      end
      if params[:selected_param] == "Proposals"
        @results_proposals = ProposalTranslations.all
        @results_fellowships = []
        @results_postal_codes = []
      end
      if params[:selected_param] == "Postal Codes"
        @results_postal_codes = Fellowship.all
        @results_fellowships = []
        @results_proposals  = []
      end
      if params[:selected_param] == "All"
        @results_postal_codes = []
        @results_fellowships = Fellowship.all
        @results_proposals  = ProposalTranslations.all
      end
      
    else
      if params[:selected_param] == "All"
        @parameter = params[:search].to_s
        @results_fellowships = Fellowship.where("lower(name) LIKE lower(:search)", search: "%#{@parameter}%")
        @results_proposals = ProposalTranslations.where("lower(title) LIKE lower(:search)", search: "%#{@parameter}%")
        @results_postal_codes = Fellowship.where("CAST(zip_code AS TEXT) LIKE lower(:search)", search: "%#{@parameter}%")
      end
      if params[:selected_param] == "Groups"
        @parameter = params[:search].to_s
        @results_fellowships = Fellowship.where("lower(name) LIKE lower(:search)", search: "%#{@parameter}%")
        @results_proposals = []
        @results_postal_codes = []
      end
      if params[:selected_param] == "Proposals"
        @parameter = params[:search].to_s
        @results_proposals = ProposalTranslations.where("lower(title) LIKE lower(:search)", search: "%#{@parameter}%")
        @results_fellowships = []
        @results_postal_codes = []
      end
      if params[:selected_param] == "Postal Codes"
        @parameter = params[:search].to_s
        @results_postal_codes = Fellowship.where("CAST(zip_code AS TEXT) LIKE lower(:search)", search: "%#{@parameter}%") 
        @results_fellowships = []
        @results_proposals  = []
      end
    end
  end

  def index
    @header = Widget::Card.header.first
    @feeds = Widget::Feed.active
    @cards = Widget::Card.body
    @remote_translations = detect_remote_translations(@feeds,
                                                      @recommended_debates,
                                                      @recommended_proposals)
  end

  def welcome
    if current_user.level_three_verified?
      redirect_to page_path("welcome_level_three_verified")
    elsif current_user.level_two_or_three_verified?
      redirect_to page_path("welcome_level_two_verified")
    else
      redirect_to page_path("welcome_not_verified")
    end
  end

  def verification
    redirect_to verification_path if signed_in?
  end

  private

    def set_user_recommendations
      @recommended_debates = Debate.recommendations(current_user).sort_by_recommendations.limit(3)
      @recommended_proposals = Proposal.recommendations(current_user).sort_by_recommendations.limit(3)
    end
end
