class FellowshipUsersController < ApplicationController
    before_filter :authenticate_user!
    
     
      private

      def fellowship_user_params
        params.require(:fellowship_user).permit(:fellowship_id, :user_id, :updated_at, :created_at, :is_fellowship_moderator, :is_fellowship_administrator, :is_fellowship_owner)
      end

    end