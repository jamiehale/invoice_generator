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
  
  module Generators
  
    class LineGroupGenerator
    
      def initialize( project, line_group )
        @project = project
        @line_group = line_group
      end
    
      def item( item_id, units )
        raise "Project item \"#{item_id}\" does not exist in project \"#{@project.name}\"" if @project.items[ item_id ].nil?
        @line_group.lines << Model::LineItem.new( @project.items[ item_id ], units )
      end
    
      def raw( description, amount )
        @line_group.lines << Model::RawItem.new( description, amount )
      end
      
      def message( message )
        @line_group.lines << Model::MessageItem.new( message )
      end
    
    end
    
  end
  
end
