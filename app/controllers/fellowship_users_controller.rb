class FellowshipUsersController < ApplicationController
    before_filter :authenticate_user!
    
      def create
        @fellowship_user = current_user.fellowship_users.build(:fellowship_id => params[:fellowship_id])
        if @fellowship_user.save
          flash[:notice] = "You have joined this group."
          redirect_to :back
        else
          flash[:error] = "Unable to join."
          redirect_to :back
        end
      end
    
      def destroy
        @fellowship_user = current_user.fellowship_users.find(params[:id])
        @fellowship_user.destroy
        flash[:notice] = "You left the Group."
        redirect_to user_path(current_user)
      end

      private

      def fellowship_user_params
        params.require(:fellowship_user).permit(:fellowship_id, :user_id, :updated_at, :created_at, :is_fellowship_moderator, :is_fellowship_administrator, :is_fellowship_owner)
      end

    end