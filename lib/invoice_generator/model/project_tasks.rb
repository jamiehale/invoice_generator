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
  
    class ProjectTasks
    
      attr_accessor :timesheet, :project, :items
    
      def initialize( timesheet, project )
        @timesheet = timesheet
        @project = project
        @items = {}
      end
      
      def item_by_id( project_item )
        @items[ project_item.id ] ||= ProjectItemTasks.new( self, project_item )
      end
      
      def add_task( day, project_item_id, units, description )
        item_tasks = item_by_id( @project.items[ project_item_id ] )
        item_tasks.add_task( day, units, description )
      end
    
    end
    
  end
  
end
