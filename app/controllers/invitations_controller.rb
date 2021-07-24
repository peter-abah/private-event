class InvitationsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_event, only: %i[new create]
  before_action :set_invitation, only: %i[update destroy]

  before_action :sanitize_invitation_params, only: %i[update]

  def new
    @event = Event.find(params[:event_id])
    redirect_to event_path(@event) and return unless @event.creator == current_user

    invited_ids = @event.invited.map(&:id)
    @uninvited = User.all.where.not(id: (invited_ids << @event.user_id))
  end

  def create
    invitation = @event.invitations.build(invitation_params)
    invitation.inviter_id = current_user.id

    invitation.save
    redirect_to event_path(@event)
  end

  def update
    @invitation.update(invitation_params)
    redirect_to user_path(current_user)
  end

  def destroy
    @invitation.destroy
    redirect_to user_path(current_user)
  end

  private

  def sanitize_invitation_params
    params[:invitation][:status] = params[:invitation][:status].to_i
  end

  def invitation_params
    params.require(:invitation).permit(:invited_id, :status)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end
end
