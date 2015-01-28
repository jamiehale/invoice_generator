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
  
    class Timesheet
    
      attr_accessor :project, :employee, :week_end, :journal_entries
    
      def initialize( project, employee, week_end )
        @project = project
        @employee = employee
        @week_end = week_end
        @journal_entries = []
      end
      
      def add_journal_entry( journal_entry )
        @journal_entries << journal_entry
      end
      
      def generate_rows
        rows = {}
        @journal_entries.each do |journal_entry|
          rows[ journal_entry.project_item.id ] ||= TimesheetRow.new( journal_entry.project_item )
          rows[ journal_entry.project_item.id ].units[ journal_entry.day ] += journal_entry.units
        end
        rows.values
      end
      
    end
    
  end
  
end
