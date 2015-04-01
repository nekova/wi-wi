module ApplicationHelper
  def markdown(text)
    unless @markdown
      renderer = Redcarpet::Render::OriginalHTML.new({
        hard_wrap: true, filter_html: true, autolink: true,
        no_intraemphasis: true, fenced_code: true, gh_blockcode: true
      })
      @markdown = Redcarpet::Markdown.new(renderer)
    end
    @markdown.render(text).html_safe
  end
end
