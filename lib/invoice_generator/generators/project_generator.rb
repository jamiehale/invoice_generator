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
  
    class ProjectGenerator
    
      def initialize( project, customers )
        @project = project
        @customers = customers
      end
    
      def name( name )
        @project.name = name
      end
      
      def short_name( short_name )
        @project.short_name = short_name
      end
      
      def client_extra( client_extra )
        @project.client_extra = client_extra
      end
    
      def customer( id )
        raise "Customer \"#{id}\" has not been defined" if @customers[ id ].nil?
        @project.customer = @customers[ id ]
      end
    
      def purchase_order( purchase_order )
        @project.purchase_order = purchase_order
      end
    
      def terms( terms )
        @project.terms = terms
      end
    
      def item( id, name, rate, options = default_item_options )
        @project.items[ id ] = Model::ProjectItem.new( id, @project, name, rate, options[ :invoice_price_decimals ], options[ :timesheet_unit_decimals ] )
      end
      
      def budget( &blk )
        BudgetGenerator.new( @project ).instance_eval( &blk )
      end
      
      private
      
        def default_item_options
          {
            :invoice_price_decimals => 2,
            :timesheet_unit_decimals => 1
          }
        end
    
    end
    
  end
  
end
