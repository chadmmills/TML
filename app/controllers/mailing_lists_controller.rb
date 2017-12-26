class MailingListsController < ApplicationController
  def new
    render locals: {
      mailing_list: MailingList.new,
      event: event,
    }
  end

  def show
    respond_to do |format|
      format.html { render locals: { mailing_list: MailingListPresenter.new(mailing_list) } }
      format.json do
        render json: { contacts: MailingListPresenter.new(mailing_list).contacts }
      end
      format.csv do
        exporter = MailingListExport.new(mailing_list)
        send_data exporter.data, filename: exporter.filename
      end
    end
  end

  def create
    respond_to do |format|
      if new_mailing_list.save
        format.html { redirect_to new_mailing_list }
      else
        format.html do
          render :new, locals: {
            mailing_list: new_mailing_list,
            event: event,
          }
        end
      end
    end
  end

  private

  def mailing_list
    @_mailing_list ||= MailingList.find(params[:id])
  end

  def mailing_params
    params.require(:mailing_list).permit(:title).merge(event: event)
  end

  def new_mailing_list
    @_mailing_list ||= MailingList.new(mailing_params)
  end

  def event
    @_event ||= Event.find(params[:event_id])
  end
end


