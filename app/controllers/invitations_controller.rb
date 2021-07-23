class InvitationsController < ApplicationController
  before_action :authenticate_user!

  def new
    # redirect_to root_path and return unless

    @event = Event.find(params[:event_id])
    invited_ids = @event.invited.map(&:id)
    @uninvited = User.all.where.not(id: invited_ids)
  end

  def create
    event = Event.find(params[:event_id])
    invitation = event.invitations.build(invitation_params)
    invitation.inviter_id = current_user.id

    if invitation.save
      redirect_to event_path(event)
    else
      puts "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#{invitation.errors.full_messages}"
      redirect_to event_path(event)
    end
  end

  def update
  end

  def destroy
  end

  def invitation_params
    params.require(:invitation).permit(:invited_id, :accepted)
  end
end
