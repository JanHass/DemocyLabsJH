class FellowshipUsersController < ApplicationController
    before_filter :authenticate_user!

    
     # def create
      #  @fellowship_user = current_user.fellowship_users.build(:fellowship_id => params[:fellowship_id])
       # if @fellowship_user.save
        #  flash[:notice] = "You have joined this fellowship."
         # redirect_to :back
       # else
         # flash[:error] = "Unable to join."
         # redirect_to :back
       # end
     # end

     # def destroy
      #@fellowship_user = current_user.fellowship_users.find(params[:id])
      #@fellowship_user.destroy
      #flash[:notice] = "You left the Group."
      #redirect_to user_path(current_user)
      #end
      def create
        
        @fellowship = Fellowship.find(params[:fellowship])
    
        @fellowship_user = current_user.fellowship_users.build(fellowship: @fellowship)
        @fellowship.members << current_user
    
        if @fellowship_user.save
            flash[:notice] = "Joined #{@fellowship.name}"
        else
            
            flash[:notice] = "Not able to join fellowship."
        end
        redirect_to fellowship_url
    end
    
    def destroy
      @fellowship_user = current_user.fellowship_users.find(params[:id])
      @fellowship = @fellowship_user.fellowship
      if @fellowship.owner == current_user
          @fellowship.destroy
          flash[:notice] = "The fellowship is destroyed"
          redirect_to user_path(current_user)
      else
          # destroy only the membership
          flash[:notice] = "You left the fellowship."
          redirect_to user_path(current_user)
      end
    end
    

      private
      def fellowship_user_params
        params.require(:fellowship_user).permit(:fellowship_id, :user_id, :is_fellowship_administrator, :is_fellowship_moderator)
      end

    end