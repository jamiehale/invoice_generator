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
  
  class LinesGenerator
    
    def initialize( invoice )
      @invoice = invoice
    end
    
    def blank
      @invoice.lines << BlankLine.new
    end
    
    def group( group_id, name, &blk )
      group = LineGroup.new( group_id, name )
      @invoice.lines << group
      @invoice.groups[ group_id ] = group
      LineGroupGenerator.new( @invoice.project, group ).instance_eval( &blk )
    end
    
    def tax_item( group_id, name )
      @invoice.lines << TaxLineItem.new( @invoice.groups[ group_id ], name )
    end
    
    def item( item_id, units )
      @invoice.lines << LineItem.new( @invoice.project.items[ item_id ], units )
    end
    
  end
  
end