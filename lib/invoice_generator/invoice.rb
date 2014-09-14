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
  
  class Invoice
    
    include LatexHelper
    
    attr_reader :number, :date, :message, :lines
    
    def initialize( number )
      @number = number
      @date = DateTime.now.strftime( "%Y-%m-%d")
      @message = ""
      @lines = Lines.new
    end
    
    def date( date )
      @date = date
    end
    
    def message( message )
      @message = message
    end
    
    def lines( &blk )
      @lines.instance_eval( &blk )
    end
    
    def total
      @lines.total
    end
    
    def dump_latex_definitions( f = STDOUT )
      $me.dump_latex_definitions( f )
      $customer.dump_latex_definitions( f )
      $project.dump_latex_definitions( f )
      dump_definition( f, "invNumber", @number )
      dump_definition( f, "invDate", @date )
      dump_definition( f, "invMessage", @message )
      dump_definition( f, "invTotal", formatted_amount( total ) )
      f.puts( "\\input{invoice.tex}" )
    end
    
    def dump_latex_rows( f = STDOUT )
      f.puts '\\\\'
      @lines.dump_latex_rows( f )
    end
    
  end
  
end
