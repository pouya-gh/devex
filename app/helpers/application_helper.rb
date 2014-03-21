module ApplicationHelper
  def markdown(text)
    render_options = { filter_html: true, hard_wrap: true, prettify: true }
    renderer = Redcarpet::Render::HTML.new(render_options)

    extensions = { no_intra_emphasis: true, tables: true, fenced_code_blocks: true, autolink: true,
                   disable_indented_code_blocks: true, space_after_headers: true, superscript: true,
                   underline: true, quote: true }
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    raw markdown.render(text)
  end
end