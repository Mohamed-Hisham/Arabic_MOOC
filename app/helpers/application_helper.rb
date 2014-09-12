module ApplicationHelper

  # For flash messages
  def twitterized_type(type)
    case type.to_sym
    when :alert   then "alert alert-danger alert-dismissable"
    when :error   then "alert alert-danger alert-dismissable"
    when :notice  then "alert alert-success alert-dismissable"
    when :success then "alert alert-success alert-dismissable"
    else type.to_s
    end
  end

  def html_direction
    if I18n.locale == 'ar'
      dir = "rtl"
    elsif I18n.locale == 'en'
      dir = "ltr"
    end
    return dir
  end
end
