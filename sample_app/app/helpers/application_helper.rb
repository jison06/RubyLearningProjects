# frozen_string_literal: true

module ApplicationHelper
  def full_title(title = '')
    base_title = 'Ruby on Rails Tutorial Sample App'
    title.length.positive? ? title << ' | ' << base_title : base_title
  end
end
