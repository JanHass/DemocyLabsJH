class ObjectionsController < ApplicationController
    skip_authorization_check
    def create
        
        # Get Article comment is attached to

        @pro_contra = ProContra.find(params[:pro_contra_id])

        # Create and save comment

        @objection = @pro_contra.objections.create(objection_params)

        # Go to the article this comment is associated with

        redirect_to pro_contra_path(@pro_contra)
    end

    def destroy
        @objection.destroy
        redirect_to account_path(@pro_contra), notice: 'Objection was successfully destroyed.'
    end

    private
    def objection_params
        params.require(:objection).permit(:user_id, :body, :debates_id, :sources, :user_first_name, :user_last_name)

    end
end
