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
  
  module Model
  
    class TimesheetRow
    
      attr_accessor :project_item, :units, :comment
    
      def initialize( project_item )
        @project_item = project_item
        @comment = nil
        @units = { :sunday => 0.0, :monday => 0.0, :tuesday => 0.0, :wednesday => 0.0, :thursday => 0.0, :friday => 0.0, :saturday => 0.0 }
      end
      
      def total
        @units.values.inject( 0.0 ) {|total,units| total + units}
      end
      
      def rounded_total
        round_or_zero( total )
      end
      
      def rounded_units
        results = {}
        @units.each { |k,v| results[ k ] = round_or_zero( v ) }
        results
      end
      
      private
      
        def round_or_zero( v )
          return '-' if v == 0
          v.round( @project_item.timesheet_unit_decimals )
        end
      
    end
    
  end
  
end
