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
        dump_latex( timesheet, filename_root )
        system( $pdflatex, output_filename( timesheet.project, filename_root ) ) if generate_tex
      end
    end
    
    private
    
      def copy_template_files( destination_path )
        FileUtils.cp_r Dir.glob( "#{$RES_PATH}/*" ), destination_path
      end
      
      def create_output_folder( project )
        FileUtils.mkdir_p( "out/#{project.id}" )
      end

      def output_filename( project, filename_root )
        "out/#{project.id}/#{filename_root}.tex"
      end

      def dump_latex( timesheet, filename_root )
        open( output_filename( timesheet.project, filename_root ), "w" ) do |f|
          Dumpers::TimesheetDumper.new( timesheet ).dump_latex( f )
        end
      end

  end
  
end
