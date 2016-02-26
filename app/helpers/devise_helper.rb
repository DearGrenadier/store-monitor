module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.join('. ')

    html = <<-HTML
      <div class="alert alert-warning" role="alert">
        <button aria-label="Close" class="close" data-dismiss="alert" type="button">
          <span aria-hidden="true">&times;</span>
        </button>
        #{messages}
      </div>
    HTML

    html.html_safe
  end
end
