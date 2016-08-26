class UploadsController < ApplicationController
  def destroy
    Upload.find(params[:id]).destroy!
    redirect_to contacts_path
  end
end
