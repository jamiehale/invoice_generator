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
  
  module Dumpers
  
    class TimesheetDumper
    
      include LatexHelper
    
      def initialize( timesheet )
        @timesheet = timesheet
      end
    
      def dump_latex( f = STDOUT )
        f.puts( '\\documentclass{template/timesheet}' )
        dump_definition( f, "timesheetWorker", @timesheet.employee.name )
        dump_definition( f, "timesheetWorkerSignatureFile", @timesheet.employee.signature_filename )
        dump_definition( f, "timesheetClient", @timesheet.project.customer.name )
        dump_definition( f, "timesheetJob", @timesheet.project.name )
        dump_definition( f, "timesheetWeekEnding", @timesheet.week_end )
        dump_definition( f, "timesheetDate", DateTime.now.strftime( '%Y-%m-%d' ) )
        dump_definition( f, "timesheetPONumber", @timesheet.project.purchase_order + client_job_extra )
        f.puts( '\\begin{document}' )
        f.puts( '\\begin{timesheet}' )
        dump_latex_rows( f )
        f.puts( '\\end{timesheet}' )
        f.puts( '\\end{document}' )
      end
    
      def dump_latex_rows( f = STDOUT )
        @timesheet.generate_rows.each do |timesheet_row|
          f.puts("\\timesheetLine{#{timesheet_row.project_item.name}}{\\timesheetLineUnits{#{timesheet_row.rounded_units[:sunday]}}{#{timesheet_row.rounded_units[:monday]}}{#{timesheet_row.rounded_units[:tuesday]}}{#{timesheet_row.rounded_units[:wednesday]}}{#{timesheet_row.rounded_units[:thursday]}}{#{timesheet_row.rounded_units[:friday]}}{#{timesheet_row.rounded_units[:saturday]}}{#{timesheet_row.rounded_total}}}{#{timesheet_row.comment}}{#{timesheet_row.project_item.line_number}}")
        end
      end
      
      private
      
        def client_job_extra
          @timesheet.project.client_extra.nil? ? "" : " (#{@timesheet.project.client_extra})"
        end
        
    end
    
  end
  
end
