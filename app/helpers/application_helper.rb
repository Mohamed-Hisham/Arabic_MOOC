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

  def humanize_secs secs
    [[60, :s], [60, :m], [24, :hr]].inject([]){ |s, (count, name)|
      if secs > 0
        secs, n = secs.divmod(count)
        s.unshift "#{n.to_i}#{name}"
      end
      s
    }.join(' ')
  end

  def check_home
    return 'home-body' if current_page?(root_path)
  end
end
