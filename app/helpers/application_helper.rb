module ApplicationHelper

  def full_title(title = '')
    base_title = 'Ruby on Rails Tutorial Sample App'
    if title.empty?
      base_title
    else
      "#{title} | #{base_title}"
    end

  end

  def button_text(text = '')
    default_text = 'Submit'
    if text.empty?
       default_text
    else
      text
    end

  end
end
