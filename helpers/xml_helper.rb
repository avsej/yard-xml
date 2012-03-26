require 'builder'

module Helpers
  module XmlHelper

    include YARD::Templates::Helpers::TextHelper
    alias :text_signature :signature

    include YARD::Templates::Helpers::HtmlHelper
    alias :html_signature :signature

    def docstring_summary(object)
      object.docstring.summary.gsub(/\n\s*/m, ' ')
    end

    def docstring_description(object, summary)
      body = object.docstring.to_s.dup
      if body.start_with?(summary)
        body[0..summary.size] = ''
      end
      html_markup_rdoc(body)
    end

  end
end
