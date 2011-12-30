module ApplicationHelper

  #Called by using <%= title %> on .html.erb pages - checks for presence of @title and defines title on a per page basis
  def title
    base_title = "CrowdDJ"
    if @title.nil?
      base_title
    else
      "#{base_title} - #{@title}"
    end
  end
 
  
end
