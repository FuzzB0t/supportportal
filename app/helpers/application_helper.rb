module ApplicationHelper

  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end

  def num2mon(num)
    case num
    when "01"
      return "Jan"
    when "02"
      return "Feb"
    when "03"
      return "Mar"
    when "04"
      return "Apr"
    when "05"
      return "May"
    when "06"
      return "Jun"
    when "07"
      return "Jul"
    when "08"
      return "Aug"
    when "09"
      return "Sep"
    when "10"
      return "Oct"
    when "11"
      return "Nov"
    when "12"
      return "Dec"
    end
  end

end
