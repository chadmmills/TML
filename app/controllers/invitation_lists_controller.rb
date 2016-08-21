class InvitationListsController < ApplicationController
  def new
    render locals: {
      invitation_list: InvitationList.new,
      event: event,
    }
  end

  def show
    render locals: { invitation_list: InvitationListPresenter.new(invitation_list) }
  end

  def create
    respond_to do |format|
      if new_invitation_list.save
        format.html { redirect_to [event, new_invitation_list] }
      else
        format.html do
          render :new, locals: {
            invitation_list: new_invitation_list,
            event: event,
          }
        end
      end
    end
  end

  private

  def invitation_list
    @_invitation_list ||= InvitationList.find(params[:id])
  end

  def invitation_params
    params.require(:invitation_list).permit(:title).merge(event: event)
  end

  def new_invitation_list
    @_invitation_list ||= InvitationList.new(invitation_params)
  end

  def event
    @_event ||= Event.find(params[:event_id])
  end
end


