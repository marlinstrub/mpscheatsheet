% MIT License

% Copyright (c) 2020 Marlin Strub, Micha Bosshart

% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:

% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.

% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

% Authors
% Marlin Strub - mstrub@robots.ox.ac.uk
% Micha Bosshart - bmicha@ethz.ch

\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{mpscheatsheet}[2020/10/02 LaTeX class for cheatsheets]%

%% Options
\RequirePackage{xcolor}
\RequirePackage{kvoptions-patch}
\RequirePackage{xkeyval}
\RequirePackage{xifthen}

% Columns
\newcommand{\@@colnum}{4}
\define@key{mpscheatsheet.cls}{columns}{
  \ifthenelse{#1 < 2 \OR \isempty{#1}}{
    \ClassError{mpscheatsheet}{Invalid column number}{Number of columns must be two or more.}
  }{
    \renewcommand{\@@colnum}{#1}
  }
}

% Section colors
\define@key{mpscheatsheet.cls}{sectioncolor}{%
  \definecolor{sectioncolor}{RGB}{#1}%
}

% We can't allow the user to pass the 'twocolumn' option to the underlying article class.
\DeclareOptionX{twocolumn}{
  \ClassError{mpscheatsheet}{Invalid option 'twocolumn'}{Use 'columns=2' instead.}
}

% Pass any unknown option to underlying article class.
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{extarticle}}

% Set default options and process any passed options.
\ExecuteOptionsX{sectioncolor={11, 93, 174}, columns=4}
\ProcessOptionsX\relax

% Load the underlying class.
\LoadClass{extarticle}%

%% Geometry
\RequirePackage[
  a4paper,%
  landscape,%
  left    = 0.4cm,%
  right   = 0.4cm,%
  top     = 0.2cm,%
  bottom  = 0.2cm,%
  includeheadfoot%
]{geometry}%

%% Whitespace
% Reduce the amount of whitespace.
\setlength{\headheight}{0.1cm}%
\setlength{\headsep}{1.3em}%
\setlength{\footskip}{0.1cm}%
\setlength{\textheight}{19.7cm}%
\setlength{\parindent}{0.0em}%
\setlength{\parskip}{0em}%
\setlength{\topskip}{-2em}%
\setlength{\topsep}{0.4em}%
\setlength{\partopsep}{0.1em}%
\setlength{\tabcolsep}{0.2em}%
\renewcommand{\arraystretch}{1}%
\renewcommand{\arraycolsep}{0.5em}%

% Also reduce the amount of whitespace around enumerations.
\RequirePackage{enumitem}%
\setlist[enumerate]{
  itemsep     = 0.0em,%
  topsep      = 0.2em,%
  parsep      = 0.2em,%
  itemindent  = 0.1em,%
  leftmargin  = 1.2em %
}
\setlist[itemize]{
  itemsep     = 0.0em,%
  topsep      = 0.2em,%
  parsep      = 0.2em,%
  itemindent  = 0.1em,%
  leftmargin  = 1.2em %
}

%% Header and footer
% Define custom commands for title, author, and email.
\def\@doctitle{}
\long\def\title#1{\def\@doctitle{#1}}
\def\@docauthor{}
\long\def\author#1{\def\@docauthor{#1}}
\def\@docemail{}
\long\def\email#1{\def\@docemail{#1}}

% Date format with month and year.
\usepackage{datetime}
\newdateformat{onlymonthandyear}{\monthname[\THEMONTH] \THEYEAR}

% Set header and footer.
\RequirePackage{fancyhdr}

% Ignore warnings about headheight and footskip being too small,
% they are set automatically by fancyhdr.
\RequirePackage{silence}
\WarningFilter{Fancyhdr}{\headheight}
\WarningFilter{Fancyhdr}{\footskip}
\RequirePackage{lastpage}
\pagestyle{fancy}
\fancyhf{}
\lhead{\textbf{\@doctitle}, \onlymonthandyear\today}
\rhead{\@docauthor{}, \texttt{\@docemail{}}}
\chead{Page \thepage{} of \pageref{LastPage}}
\cfoot{}

%% Columns
\RequirePackage{multicol}%
\AtBeginDocument{%
  \begin{multicols*}{\@@colnum}%
}%
\AtEndDocument{%
  \end{multicols*}%
}%

%% Section headings
\RequirePackage[framemethod=TikZ]{mdframed}

% Section
\newcommand*{\sect}[1]{%
  \begin{mdframed}[%
    backgroundcolor   = sectioncolor,%
    linecolor         = none,%
    leftmargin        = -3pt,%
    rightmargin       = -3pt,%
    skipabove         = 0pt,%
    skipbelow         = 0pt,%
    innertopmargin    = 0.4em,%
    innerbottommargin = 0.4em,%
    innerleftmargin   = 3pt,%
    innerrightmargin  = 3pt,%
    roundcorner       = 1pt%
  ]%
    \color{white}%
    \Large\textbf{#1}%
  \end{mdframed}%
  \vspace{-6pt}%
}%
\renewcommand\section{\@startsection%
  {section}% name
  {1}% level
  {0pt}% indent
  {0.4em plus 0.3em minus 0.1em}% beforeskip
  {0.2em plus 0.1em minus 0.0em}% afterskip
  {\sect}% style
}

% Subsection
\newcommand*{\subsect}[1]{%
  \begin{mdframed}[%
    backgroundcolor   = sectioncolor!40,%
    linecolor         = none,%
    leftmargin        = -3pt,%
    rightmargin       = -3pt,%
    skipabove         = 0pt,%
    skipbelow         = 0pt,%
    innertopmargin    = 0.3em,%
    innerbottommargin = 0.3em,%
    innerleftmargin   = 3pt,%
    innerrightmargin  = 3pt,%
    roundcorner       = 1pt%
  ]%
    \color{black}%
    \textbf{#1}%
  \end{mdframed}%
  \vspace{-6pt}%
}%
\renewcommand\subsection{\@startsection%
  {subsection}% name
  {2}% level
  {0pt}% indent
  {0.4em plus 0.1em minus 0.0em}% beforeskip
  {0.2em plus 0.1em minus 0.0em}% afterskip
  {\subsect}% style
}

% Subsubsection
\newcommand*{\subsubsect}[1]{%
  \begin{mdframed}[%
    backgroundcolor   = sectioncolor!20,%
    linecolor         = none,%
    leftmargin        = -3pt,%
    rightmargin       = -3pt,%
    skipabove         = 0pt,%
    skipbelow         = 0pt,%
    innertopmargin    = 0.2em,%
    innerbottommargin = 0.2em,%
    innerleftmargin   = 3pt,%
    innerrightmargin  = 3pt,%
    roundcorner       = 1pt%
    ]%
    \color{black}%
    \textbf{#1}%
  \end{mdframed}%
  \vspace{-6pt}
}%
\renewcommand\subsubsection{\@startsection%
  {subsubsection}% name
  {3}% level
  {0pt}% indent
  {0.4em plus 0.1em minus 0.0em}% beforeskip
  {0.2em plus 0.1em minus 0.0em}% afterskip
  {\subsubsect}% style
}
