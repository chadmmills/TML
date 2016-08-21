require 'csv'

class ContactUpload
  include ActiveModel::Model

  attr_accessor :csv_upload_file

  def upload
    CSV.foreach(csv_upload_file.path) do |row|
      ap row
      # create contact model
      # upload all in one transaction?
      # validate inputs / string
    end
  end
end
