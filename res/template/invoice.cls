% Copyright (c) 2014 Jamie Hale (http://smallarmyofnerds.com)
%
% This file is part of the invoice_generator Ruby gem.
%
% invoice_generator is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% invoice_generator is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with invoice_generator.  If not, see <http://www.gnu.org/licenses/>.
%
% This document class was derived from one originally created by Trey Hunner
%  (http://www.treyhunner.com) and contained the following copyright:

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Copyright (c) 2011 Trey Hunner                                          %
%                                                                          %
%  Permission is hereby granted, free of charge, to any person obtaining   %
%  a copy of this software and associated documentation files (the         %
%  "Software"), to deal in the Software without restriction, including     %
%  without limitation the rights to use, copy, modify, merge, publish,     %
%  distribute, sublicense, and/or sell copies of the Software, and to      %
%  permit persons to whom the Software is furnished to do so, subject to   %
%  the following conditions:                                               %
%                                                                          %
%  The above copyright notice and this permission notice shall be          %
%  included in all copies or substantial portions of the Software.         %
%                                                                          %
%  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,         %
%  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF      %
%  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                   %
%  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE  %
%  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION  %
%  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION   %
%  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.         %
%                                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{invoice}
\RequirePackage{graphicx}
\usepackage{helvet}
\renewcommand{\familydefault}{\sfdefault}
\LoadClass[12pt]{article}

\usepackage[letterpaper,hmargin=0.79in,vmargin=0.79in]{geometry}
\usepackage[parfill]{parskip}
\usepackage{longtable}

\pagestyle{empty}

\setlength{\doublerulesep}{\arrayrulewidth}
\def \tab {\hspace*{3ex}}

\newcommand{\invoiceHeader}{
  \hfil \includegraphics[width=0.6\textwidth]{\invMyLogoFilename} \hfil
  \bigskip\break
  \hrule

  \invMyAddress \hfill \invMyPhone \\
  \invMyCity, \invMyProvince \space \invMyPostalCode \hfill \invMyEmail
  \\ \\
  {\bf Invoice No:} \invNumber \\
  {\bf Date:} \invDate \\
  {\bf PO \#:} \invProjectPurchaseOrder \\
  {\bf Terms:} \invProjectTerms \\
  \\
  {\bf Invoice To:} \\
  \tab \invCustomerName \\
  \tab \invCustomerAddress \\
  \tab \invCustomerCity, \invCustomerProvince \space \invCustomerPostalCode \\
  \tab \invCustomerAttention \\
}

\newcommand{\invoiceFooter}{
  {\bf HST \#:} \invMyHstNumber \\
}

\newenvironment{invoiceTable}{

  \newcommand{\noteRow}[1]{
    \multicolumn{4}{c}{\it ##1} \\
  }
  
  \newcommand{\rawRow}[2]{
    \multicolumn{3}{l}{\it ##1} & ##2 \\
  }
  
  \newcommand{\groupNameRow}[1]{
    \multicolumn{4}{l}{##1} \\
  }
  
  \newcommand{\unitRow}[4]{
    {\it ##1} & ##2 & ##3 & ##4 \\
  }
  
  \newcommand{\blankRow}{
    \tabularnewline
  }
  
  \newcommand{\taxRow}[2]{
    \hline
    ##1 & & & ##2 \\
  }
  
  \renewcommand{\tabcolsep}{0.8ex}
  \setlength\LTleft{0pt}
  \setlength\LTright{0pt}
  \begin{longtable}{@{\extracolsep{\fill}\hspace{\tabcolsep}} p{8cm} r r r }
    \hline
    {\bf Description of Services} & \multicolumn{1}{c}{\bf Quantity} & \multicolumn{1}{c}{\bf Unit Price} & \multicolumn{1}{c}{\bf Amount} \\*
    \hline\hline
    \endhead
    \tabularnewline
    \noteRow{\invMessage}
}{
    \tabularnewline
    \hline\hline\hline
    Total & & & \invTotal \\
  \end{longtable}
}
