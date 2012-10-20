module ApplicationHelper
  
  

def sortable_field(field, title_text, field_id=nil)
  css_class = (field == sort_field) ? "hilite" : nil
  sorder = (field == sort_field) && sort_field_order == "asc" ? "desc" : "asc"
  content_tag(:th, :class => css_class) do
  link_to title_text, {:sort => field, :sorder => sorder}, {:id => field_id}
  end
end


# 
# def sortable(column, title = nil)
  # title ||= column.titleize
  # css_class = column == sort_column ? "current #{sort_direction}" : nil
  # direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  # link_to title, {:sort => column, :direction => direction}, {:class => css_class}
# end


end
