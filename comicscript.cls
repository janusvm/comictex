\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{comicscript}[2020/10/07 Comic Script]

% Options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% Packages
\RequirePackage{xparse}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[sfdefault,condensed]{cabin}
\RequirePackage[margin=2cm]{geometry}
\RequirePackage{titling}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{tabularx}

% Settings
\setlength{\parindent}{0pt}
\setlength{\parskip}{3pt}

% Commands and variables -------------------------------------------------------

% Variables for \maketitle and headers
\def\@series{}
\newcommand{\series}[1]{\def\@series{#1}}
\newcommand{\theseries}{\@series}

\def\@issue{}
\newcommand{\issue}[1]{\def\@issue{#1}}
\newcommand{\theissue}{\@issue}

% Sectioning commands
\newcommand{\page}{\section}
\NewDocumentCommand{\panel}{o}{%
  \IfNoValueTF{#1}
  {\paragraph{Panel X:}}
  {\paragraph{Panel X (#1):}}
}

% Lettering instruction commands
\newcommand{\dialogue}[2]{
  \begin{tabularx}{\textwidth}{p{0.03\textwidth}p{0.27\textwidth}X}
    XX & \MakeUppercase{#1}: & #2
  \end{tabularx}
}
\newcommand{\narration}[1]{
  \begin{tabularx}{\textwidth}{p{0.03\textwidth}p{0.27\textwidth}X}
    XX & NARRATION: & #1
  \end{tabularx}
}
\newcommand{\sfx}[1]{
  \begin{tabularx}{\textwidth}{p{0.03\textwidth}p{0.27\textwidth}X}
    XX & SFX: & #1
  \end{tabularx}
}
