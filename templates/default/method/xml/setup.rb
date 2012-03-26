def init
  xml = options[:xml_builder]
  info = {:name => object.name, :scope => object.scope}
  if object.is_attribute?
    if object.name:default_format
    end
    info[:attribute] = true
    info[:name] = object.name.to_s.sub(/=$/, '')
    if rw = object.attr_info
      if rw[:read]
        info[:reader] = true
        object.parent.children.delete(rw[:read])
        if object.docstring.start_with?("rb_define")
          object.docstring = rw[:read].docstring
        end
      end
      if rw[:write]
        info[:writer] = true
        object.parent.children.delete(rw[:write])
        if object.docstring.start_with?("rb_define")
          object.docstring = rw[:write].docstring
        end
      end
    end
  end
  if object.has_tag?(:since)
    info[:since] = object.tag(:since).text
  end
  xml.method(info) do
    xml.summary(docstring_summary(object))
    if object.tags(:overload).size > 0
      xml.description(docstring_description(object, object.docstring.summary))
      xml.notes do
        object.tags(:note).each do |note|
          xml.note(html_markup_rdoc(note.text || ""))
        end
      end if object.has_tag?(:note)
    end
    object.aliases.each do |aa|
      xml.alias(:name => aa.name)
    end
    xml.overloads do
      if object.tags(:overload).size > 0
        object.tags(:overload).each do |overload|
          describe_method(xml, object, overload)
        end
      else
        describe_method(xml, object, object)
      end
    end
  end unless object.is_alias?
end

def describe_method(xml, object, method)
  xml.overload do
    xml.signature(text_signature(method))
    xml.description(docstring_description(method, object.docstring.summary))

    option_tags = method.tags(:option)
    [:param, :yieldparam].each do |tag_name|
      xml.tag!("#{tag_name}s") do
        method.tags(tag_name).each do |param|
          info = {:name => param.name}
          default = method.parameters.assoc(param.name)
          if default && default[1]
            info[:default] = default[1]
          end
          xml.tag!(param.tag_name, info) do
            xml.types do
              if param.types
                param.types.each do |type|
                  xml.type(type)
                end
              else
                xml.type("Object")
              end
            end
            options = option_tags.select{|x| x.name.to_s == param.name}
            unless options.empty?
              xml.options do
                options.each do |option|
                  info = {:name => option.pair.name}
                  if option.pair.defaults
                    info[:default] = option.pair.defaults.first
                  end
                  xml.option(info) do
                    xml.types do
                      if option.pair.types
                        option.pair.types.each do |type|
                          xml.type(type)
                        end
                      else
                        xml.type("Object")
                      end
                    end
                    xml.description(html_markup_rdoc(option.pair.text || ""))
                  end
                end
              end
            end
            xml.description(html_markup_rdoc(param.text || ""))
          end
        end
      end if method.has_tag?(tag_name)
    end

    [:yieldreturn, :return].each do |tag_name|
      xml.tag!("#{tag_name}s") do
        ret = method.tag(tag_name)
        xml.types do
          if ret.types
            ret.types.each do |type|
              xml.type(type)
            end
          else
            xml.type("Object")
          end
        end
        xml.description(html_markup_rdoc(ret.text || ""))
      end if method.has_tag?(tag_name)
    end

    xml.exceptions do
      method.tags(:raise).each do |exc|
        xml.exception do
          xml.types do
            if exc.types
              exc.types.each do |type|
                xml.type(type)
              end
            end
          end
          xml.description(html_markup_rdoc(exc.text || ""))
        end
      end
    end if method.has_tag?(:raise)

    xml.notes do
      method.tags(:note).each do |note|
        xml.note(html_markup_rdoc(note.text || ""))
      end
    end if method.has_tag?(:note)

    xml.examples do
      method.tags(:example).each do |example|
        xml.example do
          xml.description(html_markup_rdoc(example.name || ""))
          xml.code(example.text)
        end
      end
    end if method.has_tag?(:example)
  end
end
