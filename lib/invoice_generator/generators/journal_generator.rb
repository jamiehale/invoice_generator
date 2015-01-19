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
  
    class JournalGenerator
    
      def initialize( journal, projects )
        @journal = journal
        @projects = projects
        @active_day = :sunday
      end
    
      def sunday
        @active_day = :sunday
      end
    
      def monday
        @active_day = :monday
      end
    
      def tuesday
        @active_day = :tuesday
      end
    
      def wednesday
        @active_day = :wednesday
      end
    
      def thursday
        @active_day = :thursday
      end
    
      def friday
        @active_day = :friday
      end
    
      def saturday
        @active_day = :saturday
      end
    
      def task( project_id, project_task_id, units, description )
        project = @projects[ project_id ]
        @journal.add_entry( Model::JournalEntry.new( @active_day, project.items[ project_task_id ], units, description ) )
      end
      
    end
    
  end
  
end
