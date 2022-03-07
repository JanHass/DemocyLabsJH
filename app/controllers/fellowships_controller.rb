class FellowshipsController < ApplicationController
  
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

    # New Group --> Current user add to Group with Adminstatus
    if @fellowship.save
      @n = @fellowship.fellowship_users.build(:user_id => current_user.id, :is_fellowship_owner => true)
      @n.save
      
      redirect_to @fellowship, notice: t("activerecord.attributes.fellowship.create_success")
    else
      render :new
    end
  end

  # PATCH/PUT /fellowships/1
  def update
    if @fellowship.update(fellowship_params)
      
      redirect_to @fellowship, notice: t("activerecord.attributes.fellowship.update_success")
    else
      render :edit
    end
  end

  # DELETE /fellowships/1
  def destroy
    @fellowship = Fellowship.find(params[:id])
    
    #Abfrage ob Current User = Group Owner => Nur Owner können löschen
    @fellowship.fellowship_users.each do |fellowship_user|
      if fellowship_user.user_id == current_user.id && fellowship_user.fellowship_id == @fellowship.id
        if fellowship_user.is_fellowship_owner == true
          @fellowship.destroy
          redirect_to fellowships_url, notice: t("activerecord.attributes.fellowship.delete_success")
          return
        else
          redirect_to @fellowship, notice: t("activerecord.attributes.fellowship.delete_error")
          return
        end
        break
      end
    end
    redirect_to @fellowship, notice: t("activerecord.attributes.fellowship.delete_error")
  end

  # Join a Group
  def join
    @fellowship = Fellowship.find(params[:id])

    #If Password to join is required
    if @fellowship.join_password_required?

      #If Group Password == User entered Passwort -> Join
      if params[:password] == @fellowship.join_password
        @m = @fellowship.fellowship_users.build(:user_id => current_user.id)

        respond_to do |format|
          if @m.save
            format.html { redirect_to(@fellowship, :notice => t("activerecord.attributes.fellowship.join_success")) }
          else
            format.html { redirect_to(@fellowship, :alert => t("activerecord.attributes.fellowship.join_error")) }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to(@fellowship, :alert => t("activerecord.attributes.fellowship.join_wrong_password")) }
        end
      end 

    #If NO Password to join is required
    else  
      @m = @fellowship.fellowship_users.build(:user_id => current_user.id)
      respond_to do |format|
        if @m.save
          format.html { redirect_to(@fellowship, :notice => t("activerecord.attributes.fellowship.join_success")) }
        else
          format.html { redirect_to(@fellowship, :alert => t("activerecord.attributes.fellowship.join_error")) }
        end
      end
    end
  end
  
  def changeuserrole
    @fellowship = Fellowship.find(params[:id])
    @userid = params[:userid]
    @newrole = params[:newrole]
    @currentuser_admin = false
    @currentuser_mod = false
    @currentuser_owner = false
    @multi_owner = false

    #Rolle des aktuellen Nutzers bestimmen
    @fellowship.fellowship_users.each do |current_fellowship_user|
      if current_fellowship_user.user_id == current_user.id && current_fellowship_user.fellowship_id == @fellowship.id
        if current_fellowship_user.is_fellowship_administrator
          @currentuser_admin = true
        end
        if current_fellowship_user.is_fellowship_moderator
          @currentuser_mod = true
        end
        if current_fellowship_user.is_fellowship_owner
          @currentuser_owner = true
        end
        break
      end
    end

    # Check ob min 1 weiterer Owner vorhanden ist, wenn Rolle von aktuellen Nutzer geändert wird
    # Wenn false => Error => Es muss min. 1 Owner pro Gruppe sein
    if current_user.id.to_s == @userid && @currentuser_owner
      @fellowship.fellowship_users.each do |fellowship_user|
        if fellowship_user.user_id.to_s != @userid && fellowship_user.fellowship_id == @fellowship.id && fellowship_user.is_fellowship_owner
         @multi_owner = true
         break
        end
      end
      if @multi_owner == false
        respond_to do |format|
          format.html { redirect_to(@fellowship, :alert => t("activerecord.attributes.fellowship.change_role_no_owner_error") ) }
        end
        return
      end
    end

    #fellowship user in Fellowship_Users Table finden
    @fellowship.fellowship_users.each do |fellowship_user|
      #Rolle anpassen wenn User gefunden und in DB speichern
      if fellowship_user.user_id.to_s == @userid && fellowship_user.fellowship_id == @fellowship.id

        if @newrole == "admin" && ((@currentuser_admin && !fellowship_user.is_fellowship_owner) || @currentuser_owner)
          fellowship_user.update(:is_fellowship_administrator => true, :is_fellowship_moderator => false, :is_fellowship_owner => false)
        elsif @newrole == "mod" && ((@currentuser_admin && !fellowship_user.is_fellowship_owner && !fellowship_user.is_fellowship_admin) || @currentuser_owner)
          fellowship_user.update(:is_fellowship_administrator => false, :is_fellowship_moderator => true, :is_fellowship_owner => false)
        elsif @newrole == "user" && ((@currentuser_admin && !fellowship_user.is_fellowship_owner && !fellowship_user.is_fellowship_admin) || @currentuser_owner)
          fellowship_user.update(:is_fellowship_administrator => false, :is_fellowship_moderator => false, :is_fellowship_owner => false)
        elsif @newrole =="owner" && @currentuser_owner
          fellowship_user.update(:is_fellowship_administrator => false, :is_fellowship_moderator => false, :is_fellowship_owner => true)
        else
          #Wenn keine if Abfrage greift, fehlt den aktuellen Nutzer die Freigabe für diese Aktion
          respond_to do |format|
            format.html { redirect_to(@fellowship, :alert => t("activerecord.attributes.fellowship.change_role_not_auth") ) }
          end
          return  
        end
        #Erfolgreich Rolle geändert
        respond_to do |format|
          format.html { redirect_to(@fellowship, :notice => t("activerecord.attributes.fellowship.change_role_success") ) }
        end
        return  
      end
    end
    #Allgemeiner Fehler / Gewählten Nutzer nicht gefudnen
    respond_to do |format|
      format.html { redirect_to(@fellowship, :alert => t("activerecord.attributes.fellowship.change_role_error") ) }
    end  
  end
  
  #Methode um Gruppe zu verlassen
  def leave
    @fellowship = Fellowship.find(params[:id]) 
    @origin = params[:origin]
    @current_fellowship_user
    @return_message = t("activerecord.attributes.fellowship.change_role_no_owner_error").to_s
    @return_type = "alert"

    #Fellowship_User finden
    @fellowship.fellowship_users.each do |fellowship_user|
      
      if ( current_user.id == fellowship_user.user_id && fellowship_user.fellowship_id == @fellowship.id )
        @current_fellowship_user = fellowship_user
        
        #Wenn aktueller Nutzer kein Owner, dann normal weiter
        if @current_fellowship_user.is_fellowship_owner == false
          fellowship_user.destroy
          @return_message = t("activerecord.attributes.fellowship.leave_success").to_s
          @return_type = "notice"
          break
        end 
      end     
    end

    # Wenn Aktueller Nutzer = Fellowship Owner => Üverprüfen ob noch ein weiterer Owner vorhanden ist.
    if @current_fellowship_user.is_fellowship_owner
      @return_message = t("activerecord.attributes.fellowship.change_role_no_owner_error").to_s
      @return_type = "alert"

      @fellowship.fellowship_users.each do |fellowship_user|
        if fellowship_user.user_id != @current_fellowship_user.user_id && fellowship_user.fellowship_id == @fellowship.id && fellowship_user.is_fellowship_owner
          @current_fellowship_user.destroy
          @return_message = "String"
          @return_message = t("activerecord.attributes.fellowship.leave_success").to_s
          @return_type = "notice"
          break
        end
      end 
    end
    
    #Returns with Message
    if @origin == "account" && @return_type == "alert"
      respond_to do |format|
        format.html { redirect_to(account_url, :alert => @return_message ) }  
      end
      return
    elsif @origin == "account" && @return_type == "notice"
      respond_to do |format|
        format.html { redirect_to(account_url, :notice => @return_message ) }  
      end
      return
    elsif @origin == "fellowship" && @return_type == "alert" 
      respond_to do |format|
       format.html { redirect_to(@fellowship, :alert => @return_message ) }  
      end
      return
    elsif @origin == "fellowship" && @return_type == "notice" 
      respond_to do |format|
        format.html { redirect_to(@fellowship, :notice => @return_message ) }   
      end
    else
      respond_to do |format|
        format.html { redirect_to(@fellowship, :alert => @return_message ) }   
      end
      return
    end  
  end

  #Methode um Mitglied aud der Gruppe zu entfernen
  def kick 
    @fellowship = Fellowship.find(params[:id])
    m = params[:fellowship_user_id]
    @selected_fellowship_user = @fellowship.fellowship_users.find(m)

    @fellowship.fellowship_users.each do |fellowship_user|
      if fellowship_user.user_id == current_user.id && fellowship_user.fellowship_id == @fellowship.id
        if (fellowship_user.is_fellowship_owner || (fellowship_user.is_fellowship_administrator && !@selected_fellowship_user.is_fellowship_administrator && !@selected_fellowship_user.is_fellowship_owner))
          @selected_fellowship_user.destroy

          respond_to do |format|
            format.html { redirect_to(@fellowship, :notice => t("activerecord.attributes.fellowship.kick_user_success") ) }
          end
          return
        end 
      end 
    end 
    respond_to do |format|
      format.html { redirect_to(@fellowship, :notice => t("activerecord.attributes.fellowship.kick_user_error") ) }
    end   
  end

  def tablesort

    @fellowship_users = User.order(params[:sort])
    respond_to do |format|
      format.html { redirect_to(@fellowship, :alert => "User wurde entfernt") }
    end
  
  end

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
      :admin_public_show_country, :join_password_required, :join_password, :short_description)
    end
end
