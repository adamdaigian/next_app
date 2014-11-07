class InvitationsController < ApplicationController
  http_basic_authenticate_with name: APP_CONFIG['admin_username'], password: APP_CONFIG['admin_pwd'], only: ["index"]
  include ApplicationHelper

  def new
    @invitation ||= Invitation.new
  end


  def create
    @invitation = Invitation.find_by_email(invitation_params[:email]) || Invitation.new(invitation_params)

    if @invitation.new_record?
      if @invitation.save
        respond_to do |format|
#          format.html { redirect_to "/hi/welcome/#{@invitation.token}" }
          format.html { redirect_to eb_path(welcome_path(@invitation)) }
          format.js   { render :js => "window.location = '#{eb_path(welcome_path(@invitation))}'" }
        end
      else
        respond_to do |format|
          format.html { render action: :new }
          format.js   { render partial: "shared/error_messages", status: :unprocessable_entity, content_type: 'text/html', locals: {target: @invitation} }
        end
      end
    else
      # this email is already on the waiting list,
      # redirect directly to invitation welcome page
      respond_to do |format|
#        format.html { redirect_to "/hi/welcome/#{@invitation.token}"  }
        format.html { redirect_to eb_path(welcome_path(@invitation))  }
        format.js   { render :js => "window.location = '#{eb_path(welcome_path(@invitation))}'" }
      end
    end
  end


  def welcome
    @invitation ||= Invitation.find_by(token: params[:invitation_token])
  end


  def edit
    @invitation ||= Invitation.find_by(token: params[:invitation_token])
  end


  def destroy
    @invitation ||= Invitation.find_by(token: params[:invitation_token])
  end


  def index
    @invitations = Invitation.paginate(:page => params[:page])
  end


  def validate
    @invitation = Invitation.find_by(token: params[:invitation_token])
    if @invitation.validate!
      respond_to do |format|
        format.html { redirect_to welcome_path(@invitation) }
      end
    else
      respond_to do |format|
        format.html { redirect_to index }
      end
    end
  end


  private
  def invitation_params
    params.require(:invitation).permit(:name, :email, :company, :promocode)
  end
end
