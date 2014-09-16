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

require 'date'
require 'fileutils'

require 'invoice_generator/latex_helper'

require 'invoice_generator/address'
require 'invoice_generator/address_dumper'
require 'invoice_generator/address_generator'
require 'invoice_generator/blank_line'
require 'invoice_generator/blank_line_dumper'
require 'invoice_generator/company'
require 'invoice_generator/company_dumper'
require 'invoice_generator/company_generator'
require 'invoice_generator/customer'
require 'invoice_generator/customer_dumper'
require 'invoice_generator/customer_generator'
require 'invoice_generator/invoice'
require 'invoice_generator/invoice_dumper'
require 'invoice_generator/invoice_generator'
require 'invoice_generator/invoice_processor'
require 'invoice_generator/line_group'
require 'invoice_generator/line_group_dumper'
require 'invoice_generator/line_group_generator'
require 'invoice_generator/line_item'
require 'invoice_generator/line_item_dumper'
require 'invoice_generator/lines_dumper'
require 'invoice_generator/lines_generator'
require 'invoice_generator/project'
require 'invoice_generator/project_dumper'
require 'invoice_generator/project_generator'
require 'invoice_generator/project_item'
require 'invoice_generator/tax_line_item'
require 'invoice_generator/tax_line_item_dumper'

$root_path = File.expand_path( File.join( File.dirname( __FILE__ ), '..' ) )
$res_path = File.join( $root_path, 'res' )

def company( id, &blk )
  $invoice.company.id = id
  InvoiceGenerator::CompanyGenerator.new( $invoice.company ).instance_eval( &blk )
end

def customer( id, &blk )
  $invoice.customer.id = id
  InvoiceGenerator::CustomerGenerator.new( $invoice.customer ).instance_eval( &blk )
end

def project( id, &blk )
  $invoice.project.id = id
  InvoiceGenerator::ProjectGenerator.new( $invoice.project ).instance_eval( &blk )
end

def invoice( number, &blk )
  $invoice.number = number
  InvoiceGenerator::InvoiceGenerator.new( $invoice ).instance_eval( &blk )
end

def process( filename_root, generate_tex = true )
  InvoiceGenerator::InvoiceProcessor.new.process( filename_root, generate_tex )
end

$invoice = InvoiceGenerator::Invoice.new
$pdflatex = 'pdflatex'
