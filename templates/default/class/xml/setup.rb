def init
  xml = options[:xml_builder]
  xml.class(:name => object.name, :superclass => object.superclass.name) do
    xml.summary(docstring_summary(object))
    xml.description(html_markup_rdoc(object.docstring))
    if object.respond_to?(:children)
      object.children.sort_by do |child|
        [
          child.type.to_s,
          child.respond_to?(:scope) ? child.scope.to_s : "",
          child.name.to_s
        ]
      end.each do |child|
        child.format(options.merge(:type => child.type))
      end
    end
  end
end
