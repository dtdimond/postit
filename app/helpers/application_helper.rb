module ApplicationHelper
  def fix_url(str)
    str.include?("http://") ? str : "http://#{str}"
  end

  def format_date_time(date_time)
    date_time.strftime("%m/%d/%y %I:%M%p")
  end
end
