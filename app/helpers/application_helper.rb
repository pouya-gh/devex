# need to be required to use Rouge with Redcarpet
require 'rouge/plugins/redcarpet'

module ApplicationHelper
  def markdown(text)
    text ||= ""
    render_options = { filter_html: true, hard_wrap: true, prettify: true }
    renderer = HTMLRenderer.new(render_options)

    extensions = { no_intra_emphasis: true, tables: true, fenced_code_blocks: true, autolink: true,
                   disable_indented_code_blocks: true, space_after_headers: true, superscript: true,
                   underline: true, quote: true }
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    raw markdown.render(text)
  end
end

class HTMLRenderer < Redcarpet::Render::HTML
  # to use Rouge with Redcarpet
  include Rouge::Plugins::Redcarpet
  # overriding Redcarpet method
  # github.com/vmg/redcarpet/blob/master/lib/redcarpet/render_man.rb#L9
  def block_code(code, language)
    # highlight some code with a given language lexer 
    # and formatter: html or terminal256 
    # and block if you want to stream chunks
    # github.com/jayferd/rouge/blob/master/lib/rouge.rb#L17
    Rouge.highlight(code, language || 'text', 'html') 
    # watch out you need to provide 'text' as a default, 
    # because when you not provide language in Markdown 
    # you will get error: <RuntimeError: unknown lexer >
  end
end