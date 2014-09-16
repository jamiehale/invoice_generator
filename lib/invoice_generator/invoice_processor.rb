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
  
  class InvoiceProcessor
    
    def initialize
    end
    
    def process( filename_root, generate_tex )
      copy_template_files( File.dirname( filename_root ) )
      create_output_folder
      dump_latex_definitions( filename_root )
      dump_latex_rows
      system( $pdflatex, output_filename( filename_root ) ) if generate_tex
    end
    
    private
    
      def copy_template_files( destination_path )
        FileUtils.cp_r Dir.glob( "#{$RES_PATH}/*" ), destination_path
      end
      
      def create_output_folder
        FileUtils.mkdir_p( 'out' )
      end

      def output_filename( filename_root )
        "out/#{filename_root}.tex"
      end

      def dump_latex_definitions( filename_root )
        open( output_filename( filename_root ), "w" ) do |f|
          Dumpers::InvoiceDumper.new( $invoice ).dump_latex_definitions( f )
        end
      end

      def dump_latex_rows()
        open( "out/invoice_rows.tex", "w" ) do |f|
          Dumpers::InvoiceDumper.new( $invoice ).dump_latex_rows( f )
        end
      end
    
  end
  
end
