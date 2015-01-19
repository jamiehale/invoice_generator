# Copyright (c) 2014 Jamie Hale (http://smallarmyofnerds.com)
#
# This file is part of the invoice_generator Ruby gem.
#
# invoice_generator is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# invoice_generator is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with invoice_generator.  If not, see <http://www.gnu.org/licenses/>.

Gem::Specification.new do |s|
  s.name        = 'invoice_generator'
  s.version     = '0.0.10'
  s.date        = '2014-09-12'
  s.summary     = "Invoice generator"
  s.description = "Script for creating LaTeX input files for generating invoices."
  s.license     = 'GPL-3.0'
  s.authors     = ["Jamie Hale"]
  s.email       = 'jamie@smallarmyofnerds.com'
  s.homepage    = 'http://smallarmyofnerds.com'
  s.files        = Dir["{lib}/**/*.rb", "res/**/*", "COPYING", "*.md"]
  s.require_path = 'lib'
end
