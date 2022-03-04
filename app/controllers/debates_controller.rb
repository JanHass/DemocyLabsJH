class DebatesController < ApplicationController
  include FeatureFlags
  include CommentableActions
  include FlagActions
  include Translatable

  before_action :authenticate_user!, except: [:index, :show, :map]
  before_action :set_view, only: :index
  before_action :debates_recommendations, only: :index, if: :current_user

  feature_flag :debates

  invisible_captcha only: [:create, :update], honeypot: :subtitle

  has_orders ->(c) { Debate.debates_orders(c.current_user) }, only: :index
  has_orders %w[most_voted newest oldest], only: :show

  load_and_authorize_resource
  helper_method :resource_model, :resource_name
  respond_to :html, :js

  def index_customization
    @featured_debates = @debates.featured
  end

  def show
    super
    redirect_to debate_path(@debate), status: :moved_permanently if request.path != debate_path(@debate)
    @debates_pro_contra = ProContra.where(" debate_id=#{@debate.id.to_s}")
    @debate_pc_comments_count = Objection.count("debates_id=#{@debate.id.to_s}")
  end

  def vote
    @debate.register_vote(current_user, params[:value])
    set_debate_votes(@debate)
  end

  def unmark_featured
    @debate.update!(featured_at: nil)
    redirect_to debates_path
  end

  def mark_featured
    @debate.update!(featured_at: Time.current)
    redirect_to debates_path
  end

  def disable_recommendations
    if current_user.update(recommended_debates: false)
      redirect_to debates_path, notice: t("debates.index.recommendations.actions.success")
    else
      redirect_to debates_path, error: t("debates.index.recommendations.actions.error")
    end
  end

  private

    def debate_params
      attributes = [:tag_list, :terms_of_service, :related_sdg_list, :fellowship_id]
      params.require(:debate).permit(attributes, translation_params(Debate))
    end

    def resource_model
      Debate
    end

    def set_view
      @view = (params[:view] == "minimal") ? "minimal" : "default"
    end

    def debates_recommendations
      if Setting["feature.user.recommendations_on_debates"] && current_user.recommended_debates
        @recommended_debates = Debate.recommendations(current_user).sort_by_random.limit(3)
      end
    end
end
