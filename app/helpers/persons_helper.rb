module PersonsHelper
  def person_active(active)
    icon_class = active ? 'bi bi-check-circle' : 'bi bi-x-circle'
    text_class = active ? 'text-success' : 'text-danger'

    content_tag(:span, class: text_class) do
      content_tag(:i, nil, class: icon_class)
    end
  end
end
