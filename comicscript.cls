\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{comicscript}[2020/10/07 Comic Script]

% Options ---------------------------------------------------------------------
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% Packages --------------------------------------------------------------------
\RequirePackage[margin=3cm]{geometry}
\RequirePackage{xparse}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{tabularx}
\RequirePackage{fmtcount}
\RequirePackage{xcolor}

% Commands and settings -------------------------------------------------------

% Variables for \maketitle and headers
\def\@series{}
\newcommand{\series}[1]{\def\@series{#1}}
\newcommand{\theseries}{\@series}

\def\@issue{}
\newcommand{\issue}[1]{\def\@issue{#1}}
\newcommand{\theissue}{\@issue}

\renewcommand{\maketitle}{
  {
    \begin{center}
      {\Huge\bfseries\@series~\#\@issue~---~\@title}\\[1ex]
      {\large Written by \@author}
    \end{center}
    \thispagestyle{empty}
    \pagestyle{fancy}
  }
}

\fancyhead{}
\fancyhead[R]{\color{black!30}\MakeUppercase{\slshape\@series~\#\@issue~\textbullet~\@title~\textbullet~\@author}}
\pagestyle{fancy}

% Sectioning commands and styling
% \renewcommand{\thesubsection}{\arabic{subsection}}
\newcommand{\page}{\section{Page \Numberstring{section}}}
\NewDocumentCommand{\panel}{o}{\subsection{Panel \arabic{subsection}\IfNoValueTF{#1}{}{ (#1)}}}

\titleformat{\section}[hang]{\normalfont\Large\bfseries}{}{0pt}{}
\titleformat{\subsection}[runin]{\normalfont\bfseries}{}{0pt}{}[:]

% Lettering instruction commands
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}
\newenvironment{lettering}
  {\medskip\par\noindent\tabularx{\textwidth}{ R{0.05\textwidth} p{0.25\textwidth} X }}
  {\endtabularx}
\newcounter{letteringitem}[section]
\NewDocumentCommand{\letteringitem}{ m o m }{
  \stepcounter{letteringitem}
  \arabic{letteringitem}. & \MakeUppercase{#1}\IfNoValueTF{#2}{}{ (\MakeUppercase{#2})}: & #3
}
\NewDocumentCommand{\dialogue}{ m o m }{\letteringitem{#1}[#2]{#3}}
\NewDocumentCommand{\narration}{ o m }{\letteringitem{NARRATION}[#1]{#2}}
\NewDocumentCommand{\sfx}{ m }{\letteringitem{SFX}{#1}}
