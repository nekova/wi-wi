module ApplicationHelper
  def markdown(text)
    unless @markdown
      renderer = Redcarpet::Render::OriginalHTML.new({
        hard_wrap: true, filter_html: true, gh_blockcode: true
      })
      @markdown = Redcarpet::Markdown.new(renderer, autolink: true, fenced_code_blocks: true)
    end
    @markdown.render(text).html_safe
  end
end
