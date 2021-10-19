module ApplicationHelper
  def format_runtime(minutes)
    hours = minutes / 60
    min = minutes % 60
    "#{hours} hr #{min} min"
  end
end
