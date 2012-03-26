YARD::Templates::Engine.register_template_path File.dirname(__FILE__) + '/templates'
require File.dirname(__FILE__) + '/helpers/xml_helper'
YARD::Templates::Template.extra_includes = [Helpers::XmlHelper]
