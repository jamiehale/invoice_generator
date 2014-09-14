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
  
  class Lines
    
    def initialize
      @lines = []
      @groups = {}
    end
    
    def blank
      @lines << BlankLine.new
    end
    
    def group( group_id, name, &blk )
      group = LineGroup.new( group_id, name )
      group.instance_eval( &blk )
      @lines << group
      @groups[ group_id ] = group
    end
    
    def tax_item( group_id, name )
      @lines << TaxLineItem.new( @groups[ group_id ], name )
    end
    
    def item( item_id, units )
      @lines << LineItem.new( item_id, units )
    end
    
    def total
      @lines.inject( 0.0 ) { |result,line| result + line.total }
    end
    
    def dump_latex_rows( f )
      @lines.each do |line|
        line.dump_latex_rows( f )
      end
    end
    
  end
  
end
