\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{comicscript}[2020/10/09 Comic Script]

% Options ---------------------------------------------------------------------
% Is the script paged or not? This affects the numbering of panel labels
\newif\ifcomicscript@unpaged
\comicscript@unpagedfalse
\DeclareOption{paged}{\comicscript@unpagedfalse}
\DeclareOption{unpaged}{\comicscript@unpagedtrue}

% Include a titlepage? This puts the output of \maketitle on its own page
\newif\ifcomicscript@titlepage
\comicscript@titlepagefalse
\DeclareOption{titlepage}{\comicscript@titlepagetrue}
\DeclareOption{notitlepage}{\comicscript@titlepagefalse}

% Options passed to the article class
\DeclareOption{twocolumn}{\OptionNotUsed}
\DeclareOption{twoside}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions*\relax
\LoadClass{article}

% Packages --------------------------------------------------------------------
\RequirePackage[margin=1in]{geometry}
\RequirePackage{xparse}
\RequirePackage[pagestyles]{titlesec}
\RequirePackage{tabularx}
\RequirePackage{fmtcount}
\RequirePackage{xcolor}

% Commands and settings -------------------------------------------------------
% Handle mutually exclusive options
\ifcomicscript@unpaged
  \renewcommand{\thesubsection}{\arabic{subsection}}
\fi

\AtBeginDocument{
  \ifx\@title\empty
    \ifx\@series\empty
      \ClassError{comicscript}{Either \noexpand\title or \noexpand\series must be given}\@ehc
    \fi
  \fi
}

% Variables for \maketitle and headers
\def\@author{\ClassError{comicscript}{No \noexpand\author given}\@ehc}
\gdef\@title{}
\gdef\@series{}
\gdef\@issue{}
\DeclareRobustCommand\series[2]{
  \gdef\@series{#1}
  \gdef\@issue{#2}
}

\renewcommand{\maketitle}{
  \ifcomicscript@titlepage
    \hspace{0pt}\vfill
    \@maketitle
    \vfill\hspace{0pt}
    \clearpage
  \else
    \@maketitle
  \fi
}

\renewcommand{\@maketitle}{
  \begin{center}
    \ifx\@series\empty
      {\Huge\bfseries\@title}
    \else
      \ifx\@title\empty
        {\Huge\bfseries\@series~\#\@issue}
      \else
        {\Huge\bfseries\@series~\#\@issue~---~\@title}
      \fi
    \fi
    \medskip\par{\large Written by \@author}\bigskip
  \end{center}
  \thispagestyle{empty}
}

\newpagestyle{main}{
  \sethead{}{}{
    \color{black!30}\MakeUppercase{%
      \small\slshape%
      \ifx\@series\empty\else{\@series~\#\@issue~\textbullet~}\fi%
      \ifx\@title\empty\else{\@title~\textbullet~}\fi%
      \@author
    }
  }
  \setfoot{}{}{}
}
\pagestyle{main}

% Sectioning commands and styling
\ifcomicscript@unpaged\else\newcommand{\page}{\section{Page \Numberstring{section}}}\fi
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
