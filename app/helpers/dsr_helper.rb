module DsrHelper

  def get_total_time(time_difference)
    time = ""
    if time_difference.present?
      difference = Time.at(time_difference).utc
      day, hour, mint = difference.strftime("%d-%H-%M").split("-")
      hour = day.to_i > 1 ? (hour.to_i + ((24 * day.to_i) - 24)) : hour
      if hour.to_i > 0
        time = "#{hour.to_i} Hr#{hour.to_i > 1 ? 's' : ''}"
      end
      if mint.to_i > 0
        time = "#{time ? time + " " : ""}#{mint} Mins"
      end
    end
    time
  end

end
