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
  
    class ProjectItem
    
      attr_accessor :id, :project, :name, :rate, :invoice_price_decimals, :timesheet_unit_decimals, :line_number
    
      def initialize( id, project, name, rate, invoice_price_decimals, timesheet_unit_decimals )
        @id = id
        @project = project
        @name = name
        @rate = rate
        @invoice_price_decimals = invoice_price_decimals
        @timesheet_unit_decimals = timesheet_unit_decimals
        @line_number = nil
      end
    
      def rounded_rate
        @rate.round( @invoice_price_decimals )
      end
    
    end
    
  end
  
end
