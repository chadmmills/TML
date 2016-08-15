class EventDecorator < SimpleDelegator

  def event_date_formatted
    event_date.strftime("%m-%d-%Y")
  end

  def event_date
    super || NullEventDate.new
  end

  class NullEventDate
    def strftime(*args)
      ""
    end
  end

end
