# need to be required to use Rouge with Redcarpet
require 'rouge/plugins/redcarpet'

module ApplicationHelper
  def gravatar_for(user, options = {size: 80})
    email_hash = Digest::MD5.hexdigest(user.email)
    url = "https://gravatar.com/avatar/#{email_hash}?size=#{options[:size]}"
    image_tag(url, alt: "#{user.first_name} #{user.last_name}")
  end

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