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

\ProvidesClass{timesheet}
\LoadClass{report}
\usepackage[margin=0.5in]{geometry}
\usepackage{graphicx}
\usepackage{array}

\usepackage[table]{xcolor}
\usepackage{color, colortbl}
\definecolor{Gray}{gray}{0.92}
\definecolor{White}{gray}{1.0}

\renewcommand{\familydefault}{\sfdefault}

\newcommand{\timesheetLineUnits}[8]{#1 & #2 & #3 & #4 & #5 & #6 & #7 & #8}
\newcommand{\timesheetLine}[4]{#1 & #2 & #3 & #4 \\}

\newenvironment{timesheet}{
\hfil \includegraphics[width=0.6\textwidth]{../../res/SAON_logo_header.png} \hfil
\bigskip\break
\hrule

\vspace{1cm}

{\Large \textbf{Timesheet - \timesheetWorker}}

\vspace{1cm}

\begin{tabular}{>{\raggedleft\arraybackslash}p{3cm} l}
  Week Ending: & \timesheetWeekEnding \\
  Client: & \timesheetClient \\
  Project: & \timesheetJob \\
  Purchase Order: & \timesheetPONumber \\
\end{tabular}

\vspace{1cm}

\rowcolors{3}{White}{Gray}
\begin{tabular}{|l|c|c|c|c|c|c|c||c|>{\centering\arraybackslash}p{3cm}|c|}
    \hline
    \rowcolor{Gray}
    \multicolumn{11}{|c|}{\normalsize Labour and Expenses} \\
    \hline
    \rowcolor{Gray}
    Description & Sun & Mon & Tue & Wed & Thu & Fri & Sat & Total & Comments & Line \# \\
    \hline
}{
    \hline
  \end{tabular}
  \rowcolors{1}{}{}
  
  \vspace{1cm}
  
  \begin{tabular}{>{\raggedleft\arraybackslash}p{3cm} c}
    Signature: & \parbox[c]{8em}{\includegraphics[width=30mm]{\timesheetWorkerSignatureFile}} \\
    & 2015-01-15 \\
  \end{tabular}
  
  \vspace{2cm}
  
  \begin{tabular}{>{\raggedleft\arraybackslash}p{3cm} l}
    Client Signature: &  \\
  \end{tabular}
}
