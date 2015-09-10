module MarkdownHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        superscript: true,
        space_after_headers: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
end
