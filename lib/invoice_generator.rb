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

require 'invoice_generator/blank_line'
require 'invoice_generator/customer'
require 'invoice_generator/invoice'
require 'invoice_generator/line_group'
require 'invoice_generator/line_item'
require 'invoice_generator/lines'
require 'invoice_generator/me'
require 'invoice_generator/project'
require 'invoice_generator/project_item'
require 'invoice_generator/tax_line_item'

def me( name, &blk )
  $me = InvoiceGenerator::Me.new( name )
  $me.instance_eval( &blk )
end

def customer( name, &blk )
  $customer = InvoiceGenerator::Customer.new( name )
  $customer.instance_eval( &blk )
end

def project( name, &blk )
  $project = InvoiceGenerator::Project.new( name )
  $project.instance_eval( &blk )
end

def invoice( number, &blk )
  $invoice = InvoiceGenerator::Invoice.new( number )
  $invoice.instance_eval( &blk )
end

$me = nil
$customer = nil
$project = nil
$invoice = nil

def copy_template_files( destination_path )
  resources_path = File.expand_path( File.dirname( __FILE__ ) + '/../res' )
  FileUtils.cp_r Dir.glob( "#{resources_path}/*" ), destination_path
end

def dump( filename_root )
  copy_template_files( File.dirname( filename_root ) )
  open( "#{filename_root}.tex", "w" ) do |f|
    $invoice.dump_latex_definitions( f )
  end
  open( "invoice_rows.tex", "w" ) do |f|
    $invoice.dump_latex_rows( f )
  end
end
