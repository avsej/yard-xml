def init
  xml = options[:xml_builder]
  xml.constant(:name => object.name, :value => object.value) do
    xml.description(html_markup_rdoc(object.docstring))
  end
end
