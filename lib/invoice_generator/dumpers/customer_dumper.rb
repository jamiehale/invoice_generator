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
  
  module Dumpers
  
    class CustomerDumper
    
      include LatexHelper
      include AddressDumper
    
      def initialize( customer )
        @customer = customer
      end
    
      def dump_latex_definitions( f )
        dump_definition( f, "invCustomerName", @customer.name )
        dump_address_definitions( f, @customer, "Customer" )
        dump_definition( f, "invCustomerAttention", @customer.attention )
      end
    
    end
    
  end
  
end
