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
  
  class JournalProcessor
    
    def initialize
    end
    
    def process( journal, filename_root, generate_tex )
      copy_template_files( File.dirname( filename_root ) )
      journal.timesheets.each_value do |timesheet|
        create_output_folder( timesheet.project )
        dump_latex( timesheet )
        system( $pdflatex, output_filename( timesheet ) ) if generate_tex
        
        dump_budget_report( timesheet )
      end
    end
    
    private
    
      def copy_template_files( destination_path )
        FileUtils.cp_r Dir.glob( "#{$RES_PATH}/*" ), destination_path
      end
      
      def create_output_folder( project )
        FileUtils.mkdir_p( "out/#{project.id}" )
      end

      def output_filename( timesheet )
        filename = "#{timesheet.week_end} #{timesheet.project.short_name} Timesheet"
        "out/#{timesheet.project.id}/#{filename}.tex"
      end

      def dump_latex( timesheet )
        open( output_filename( timesheet ), "w" ) do |f|
          Dumpers::TimesheetDumper.new( timesheet ).dump_latex( f )
        end
      end
      
      def dump_budget_report( timesheet )
        budget_items = {}
        timesheet.project.budget.items.each_value do |budget_item|
          budget_items[ budget_item.id ] = [ budget_item.amount, 0.0 ]
        end
        timesheet.journal_entries.each do |journal_entry|
          budget_items[ journal_entry.budget_item.id ][ 1 ] += journal_entry.units * journal_entry.project_item.rate
        end
        budget_items.each do |id,amounts|
          puts "#{id}: #{amounts[0]} -- #{amounts[1]}"
        end
      end

  end
  
end
