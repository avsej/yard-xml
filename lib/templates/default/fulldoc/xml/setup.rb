# -*- encoding: utf-8 -*-
# Author:: Couchbase <info@couchbase.com>
# Copyright:: 2012 Couchbase, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
