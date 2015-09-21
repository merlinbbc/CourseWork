module ApplicationHelper

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        space_after_headers: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  module ApplicationHelper

    def paginate objects, options = {}
      options.reverse_merge!( theme: 'twitter-bootstrap' )

      super( objects, options )
    end

  end

  def set_theme(i)
    if current_user.present?
      user = User.new
      user = current_user
      user.theme = i
      user.save
      #redirect_to root_path
    end
  end

end
