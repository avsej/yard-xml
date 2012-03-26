def init
  Templates::Engine.with_serializer('index.xml', options[:serializer]) do
    xml = Builder::XmlMarkup.new(:indent => 4)
    xml.documetation do
      YARD::Registry.root.children.sort_by do |child|
        [
          child.type.to_s,
          child.respond_to?(:scope) ? child.scope.to_s : "",
          child.name.to_s
        ]
      end.each do |child|
        child.format(options.merge(:xml_builder => xml))
      end
    end
  end
end
