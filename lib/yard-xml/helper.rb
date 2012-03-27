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

require 'builder'

module YardXML
  module Helper

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
