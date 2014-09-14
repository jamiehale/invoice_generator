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
  
  class LineItem
    
    include LatexHelper
    
    attr_accessor :id, :units
    
    def initialize( id, units )
      @id = id
      @units = units
      @project_item = $project.items[ @id ]
    end
    
    def total
      @project_item.rounded_rate * @units
    end
    
    def dump_latex_rows( f )
      f.puts "\\unitRow{#{@project_item.name}}{#{@units}}{#{rate}}{#{formatted_amount(total)}}"
    end
    
    private
    
      def rate
        formatted_amount( @project_item.rounded_rate, @project_item.decimals )
      end
  end
  
end
