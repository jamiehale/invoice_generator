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
require 'yaml'

require 'invoice_generator/invoice_processor'
require 'invoice_generator/journal_processor'

require 'invoice_generator/model/address'
require 'invoice_generator/model/blank_line'
require 'invoice_generator/model/budget'
require 'invoice_generator/model/budget_item'
require 'invoice_generator/model/companies'
require 'invoice_generator/model/company'
require 'invoice_generator/model/customer'
require 'invoice_generator/model/customers'
require 'invoice_generator/model/employee'
require 'invoice_generator/model/employees'
require 'invoice_generator/model/invoice'
require 'invoice_generator/model/journal'
require 'invoice_generator/model/journal_entry'
require 'invoice_generator/model/line_group'
require 'invoice_generator/model/line_item'
require 'invoice_generator/model/project'
require 'invoice_generator/model/projects'
require 'invoice_generator/model/project_item'
require 'invoice_generator/model/task'
require 'invoice_generator/model/tax_line_item'
require 'invoice_generator/model/timesheet'
require 'invoice_generator/model/timesheet_row'

require 'invoice_generator/dumpers/latex_helper'
require 'invoice_generator/dumpers/address_dumper'
require 'invoice_generator/dumpers/blank_line_dumper'
require 'invoice_generator/dumpers/company_dumper'
require 'invoice_generator/dumpers/customer_dumper'
require 'invoice_generator/dumpers/invoice_dumper'
require 'invoice_generator/dumpers/line_group_dumper'
require 'invoice_generator/dumpers/line_item_dumper'
require 'invoice_generator/dumpers/lines_dumper'
require 'invoice_generator/dumpers/project_dumper'
require 'invoice_generator/dumpers/tax_line_item_dumper'
require 'invoice_generator/dumpers/timesheet_dumper'

require 'invoice_generator/generators/address_generator'
require 'invoice_generator/generators/budget_generator'
require 'invoice_generator/generators/companies_generator'
require 'invoice_generator/generators/company_generator'
require 'invoice_generator/generators/customer_generator'
require 'invoice_generator/generators/customers_generator'
require 'invoice_generator/generators/employee_generator'
require 'invoice_generator/generators/employees_generator'
require 'invoice_generator/generators/invoice_generator'
require 'invoice_generator/generators/journal_generator'
require 'invoice_generator/generators/line_group_generator'
require 'invoice_generator/generators/lines_generator'
require 'invoice_generator/generators/project_generator'
require 'invoice_generator/generators/projects_generator'

$ROOT_PATH = File.expand_path( File.join( File.dirname( __FILE__ ), '..' ) )
$RES_PATH = File.join( $ROOT_PATH, 'res' )

$pdflatex = 'pdflatex'

$companies = InvoiceGenerator::Model::Companies.new
$customers = InvoiceGenerator::Model::Customers.new
$projects = InvoiceGenerator::Model::Projects.new
$employees = InvoiceGenerator::Model::Employees.new
$invoice = InvoiceGenerator::Model::Invoice.new
$journal = InvoiceGenerator::Model::Journal.new

def companies( &blk )
  InvoiceGenerator::Generators::CompaniesGenerator.new( $companies ).instance_eval( &blk )
end

def customers( &blk )
  InvoiceGenerator::Generators::CustomersGenerator.new( $customers ).instance_eval( &blk )
end

def projects( &blk )
  InvoiceGenerator::Generators::ProjectsGenerator.new( $projects, $customers ).instance_eval( &blk )
end

def employees( &blk )
  InvoiceGenerator::Generators::EmployeesGenerator.new( $employees ).instance_eval( &blk )
end

def invoice( number, &blk )
  $invoice.number = number
  InvoiceGenerator::Generators::InvoiceGenerator.new( $invoice, $companies, $projects ).instance_eval( &blk )
end

def journal( employee_id, week_end, &blk )
  $journal.employee = $employees[ employee_id ]
  $journal.week_end = week_end
  InvoiceGenerator::Generators::JournalGenerator.new( $journal, $projects ).instance_eval( &blk )
end

def process( filename_root, generate_tex = true )
  InvoiceGenerator::InvoiceProcessor.new.process( filename_root, generate_tex )
end

def process_journal( filename_root, generate_tex = true )
  InvoiceGenerator::JournalProcessor.new.process( $journal, filename_root, generate_tex )
end
