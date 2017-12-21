class MailingListExport
  def initialize(mailing_list)
    @mailing_list = mailing_list
  end

  def data
    attributes = %w{name street_1 street_2 city state zipcode country}
    CSV.generate(headers: true) do |csv|
      csv << attributes

      mailing_list.contacts.by_name.each do |contact|
        csv << attributes.map { |attr| contact.send(attr) }
      end
    end
  end

  def filename
    "#{mailing_list.title}-export-#{Time.zone.now.strftime("%b%d%I:%M%p")}.csv".strip
  end


  private
  attr_reader :mailing_list
end
