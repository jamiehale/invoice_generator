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
  
    class InvoiceDumper
    
      include LatexHelper
    
      def initialize( invoice )
        @invoice = invoice
      end
    
      def dump_latex_definitions( f = STDOUT )
        CompanyDumper.new( @invoice.company ).dump_latex_definitions( f )
        ProjectDumper.new( @invoice.project ).dump_latex_definitions( f )
        dump_definition( f, "invNumber", @invoice.number )
        dump_definition( f, "invDate", @invoice.date )
        dump_definition( f, "invMessage", @invoice.message )
        dump_definition( f, "invTotal", formatted_amount( @invoice.total ) )
        f.puts( "\\input{template/invoice.tex}" )
      end
    
      def dump_latex_rows( f = STDOUT )
        f.puts '\\\\'
        LinesDumper.new( @invoice.lines ).dump_latex_rows( f )
      end
    
    end
    
  end
  
end
