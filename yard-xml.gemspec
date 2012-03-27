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

$:.push File.expand_path('../lib', __FILE__)
require 'yard'
require 'yard-xml/version'

Gem::Specification.new do |s|
  s.name        = 'yard-xml'
  s.version     = YardXML::VERSION
  s.author      = 'Couchbase'
  s.email       = 'support@couchbase.com'
  s.license     = 'ASL-2'
  s.homepage    = 'http://couchbase.org'
  s.summary     = %q{XML plugin for YARD tool}
  s.description = %q{This plugin allows to render YARD documentation into the single XML file for further processing.}

  s.files         = `git ls-files`.split("\n")
  s.add_dependency 'yard'
  s.require_paths = ['lib']
end
