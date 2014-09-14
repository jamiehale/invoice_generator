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

module InvoiceGenerator
  
  class Me
    
    include LatexHelper
    include Address
    
    attr_reader :name
    
    def initialize( name )
      @name = name
    end
    
    def email( email )
      @email = email
    end
    
    def hst( hst )
      @hst = hst
    end
    
    def dump_latex_definitions( f )
      dump_definition( f, "invMyName", @name )
      dump_definition( f, "invMyEmail", @email )
      dump_definition( f, "invMyHstNumber", @hst )
      dump_address_definitions( f, "My" )
    end
    
  end
  
end
