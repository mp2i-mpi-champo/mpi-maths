\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{../commun/prepacours}[2026/09/05 Classe LaTeX unifiée Cours/Exos Prépa]

\LoadClass[a4paper,11pt]{article}

% =============================================================================
% MODE
% =============================================================================
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=prepa, prefix=prepa@}
\DeclareBoolOption[false]{td}
\ProcessKeyvalOptions*

% =============================================================================
% PACKAGES
% =============================================================================
\RequirePackage[french]{babel}
\RequirePackage{amsmath,amsthm}
\RequirePackage{mathrsfs}
\RequirePackage{xcolor}
\RequirePackage[most]{tcolorbox}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{tikz}
\RequirePackage{fontspec}
\RequirePackage{unicode-math}
\RequirePackage{fontawesome5}
\RequirePackage{graphicx}
\RequirePackage{scrlayer-notecolumn}
\RequirePackage{scrlayer-fancyhdr}
\RequirePackage{needspace}
\RequirePackage{atbegshi}
\RequirePackage[normalem]{ulem}
\RequirePackage{etoolbox}
\RequirePackage{pgfplots}
\RequirePackage{titletoc}
\RequirePackage{enumitem}
\RequirePackage{ifthen}
\RequirePackage{soul}

\setmainfont{fbb}[
  Extension      = .otf,
  UprightFont    = *-Regular,
  BoldFont       = *-Bold,
  ItalicFont     = *-Italic,
  BoldItalicFont = *-BoldItalic,
  Numbers        = {Lining, Proportional}
]

\setmathfont{Libertinus Math}[Scale=MatchLowercase]

\newfontfamily\chapitrenumfont{UnifrakturCook}[
  Extension = .ttf,
  UprightFont = *-Bold,
  Scale = 1.15
]

\DeclareFontFamily{U}{skulls}{}
\DeclareFontShape{U}{skulls}{m}{n}{ <-> skull }{}

\DeclareRobustCommand{\skull}{%
  \text{\usefont{U}{skulls}{m}{n}\symbol{'101}}%
}

\setcounter{tocdepth}{2} 

% =============================================================================
% CONFIGURATION GÉOMÉTRIE
% =============================================================================
\ifprepa@td
  \geometry{
    top=2cm,
    bottom=2cm,
    left=2cm,
    right=2cm,
    headheight=32pt,
  }
\else
  \geometry{
    top=2cm,
    bottom=2cm,
    left=1.5cm,
    right=5cm,
    marginparwidth=3.5cm,
    marginparsep=0.5cm,
    headheight=12pt,
  }
\fi

\setlength{\parindent}{0pt}
\setlength{\parskip}{0.3em}

\newcommand{\passerenmodecours}{%
  \clearpage
  \prepa@tdfalse
  \newgeometry{
    top=2cm,
    bottom=2cm,
    left=1.5cm,
    right=5cm,
    marginparwidth=3.5cm,
    marginparsep=0.5cm,
    headheight=12pt,
  }%
  \fancyhfoffset[R]{\dimexpr\marginparsep+\marginparwidth\relax}%
}

\newcommand{\passerenmodeexos}{%
  \clearpage
  \prepa@tdtrue
  \newgeometry{
    top=2cm,
    bottom=2cm,
    left=2cm,
    right=2cm,
    headheight=30pt,
  }%
  \fancyhfoffset[R]{0pt}%
  \thispagestyle{premierepagechapitre}
  \displaychapitrebanner
}

\addtolength{\topmargin}{10pt}
\addtolength{\headsep}{-10pt}
% =============================================================================
% COULEURS
% =============================================================================
\definecolor{vorange}{RGB}{230, 120, 0}
\definecolor{bg_theoreme}{RGB}{255, 237, 222}
\definecolor{bg_def_start}{RGB}{255, 237, 222}

\definecolor{ideayellow}{RGB}{230, 160, 0}
\definecolor{dangerred}{RGB}{220, 40, 40}

% =============================================================================
% COMPTEURS ET CHAPITRES
% =============================================================================
\newcounter{chapitre}
\renewcommand{\thechapitre}{\arabic{chapitre}}

\newcounter{coursenv}[chapitre]
\renewcommand{\thecoursenv}{\thechapitre.\arabic{coursenv}}

\newcommand{\annee}[1]{\gdef\@annee{#1}}
\newcommand{\filiere}[1]{\gdef\@filiere{#1}}
\newcommand{\etablissement}[1]{\gdef\@etablissement{#1}}

\newcommand{\@numchapitre}{}
\newcommand{\@titrechapitre}{}
\newcommand{\@annee}{}
\newcommand{\@filiere}{}
\newcommand{\@etablissement}{}

\newcommand{\setchapitre}[1]{%
  \setcounter{chapitre}{#1}%
  \addtocounter{chapitre}{-1}%
  \refstepcounter{chapitre}%
  \setcounter{coursenv}{0}%
}

\newcommand{\chapitre}[2]{%
  \setchapitre{#1}%
  \gdef\@numchapitre{#1}%
  \gdef\@titrechapitre{#2}%
  \markboth{Chapitre #1 -- #2}{}%
}

\setlist[itemize,1]{
  label=\raisebox{0.1ex}{$\triangleright$},
  leftmargin=*,
  itemsep=2pt
}
\setlist[itemize,2]{
  label=\raisebox{0.15ex}{$\char"25CA\relax$},
  leftmargin=*,
  itemsep=2pt
}
\setlist[itemize,3]{
  label=\raisebox{0.1ex}{$\square$},
  leftmargin=*,
  itemsep=2pt
}
\setlist[itemize,4]{label=\textbullet}

% =============================================================================
% THÉORÈMES / PROPS / DEFS / EXEMPLES
% =============================================================================
\tcbset{
	vbase/.style={
      enhanced,
      sharp corners,
      boxrule=0.4pt,
      colframe=black!85,
      width=\dimexpr\linewidth-1.8pt\relax,
      drop shadow={vorange!60, xshift=1.8pt, yshift=-1.8pt},
      left=8pt,
      right=8pt,
      top=6pt,
      bottom=6pt,
      unbreakable,
      fonttitle=\bfseries\upshape\color{vorange!95!black},
      theorem style=plain,
      separator sign={\textnormal{\upshape~--~}},
      terminator sign={~:~},
      description font=\itshape,
      description color=vorange!95!black,
    },
    vexstyle/.style={
    enhanced,
    breakable,
    sharp corners,
    width=\dimexpr\linewidth-1.8pt\relax,
    boxrule=0.4pt,
    colframe=black!25,
    interior style={left color=vorange!3, right color=white},
    borderline west={1.8pt}{0pt}{vorange},
    left=9pt,
    right=9pt,
    top=10pt,
    bottom=7pt,
    fonttitle=\bfseries\color{vorange!90!black},
    attach boxed title to top left={
      xshift=10pt,
      yshift=-\tcboxedtitleheight/2
    },
    boxed title style={
      sharp corners,
      boxrule=0pt,
      colframe=white,
      colback=white,
      left=4pt,
      right=4pt,
      top=0pt,
      bottom=0pt,
    }
  }
}

\newtcbtheorem[use counter=coursenv, number within=chapitre]{definition}{Définition}{
  vbase,
  frame empty,
  colback=white,
  no shadow,
  interior style={left color=bg_def_start, right color=white},
  fontupper=\normalfont\upshape
}{definition}

\newtcbtheorem[use counter=coursenv, number within=chapitre]{theoreme}{Théorème}{
  vbase,
  colback=bg_theoreme,
  fontupper=\itshape
}{theoreme}

\newtcbtheorem[use counter=coursenv, number within=chapitre]{proposition}{Proposition}{
  vbase,
  colback=white,
  fontupper=\itshape
}{proposition}

\newtcbtheorem[use counter=coursenv, number within=chapitre]{corollaire}{Corollaire}{
  vbase,
  colback=white,
  fontupper=\itshape
}{corrollaire}

\newenvironment{exemple}[1][]{%
  \refstepcounter{coursenv}%
  \begin{tcolorbox}[
    vexstyle,
    title={Exemple \thecoursenv\ifblank{#1}{}{\textnormal{~--~(#1)}}}
  ]%
}{%
  \end{tcolorbox}%
}

\newenvironment{theorement}[2]{\begin{theoreme}{#1}{#2}}{\end{theoreme}}
\newenvironment{propositionnt}[2]{\begin{proposition}{#1}{#2}}{\end{proposition}}
\newenvironment{corollairent}[2]{\begin{corollaire}{#1}{#2}}{\end{corollaire}}
\newenvironment{proprietent}[2]{\begin{propriete}{#1}{#2}}{\end{propriete}}
\newenvironment{definitionnt}[2]{\begin{definition}{#1}{#2}}{\end{definition}}

\theoremstyle{remark}
\newtheorem*{remarque}{Remarque}

% =============================================================================
% NOTES DANS LA MARGE
% =============================================================================
\DeclareNewNoteColumn[%
  position=\dimexpr1in+\oddsidemargin+\textwidth+\marginparsep\relax,
  width=\marginparwidth,
  font=\normalfont
]{margincol}

\newtcolorbox{marginbox}[3][]{%
  enhanced,
  nobeforeafter,
  unbreakable,
  sharp corners,
  colback=white,
  colframe=#2,
  boxrule=0.6pt,
  width=\dimexpr\marginparwidth-1.8pt\relax,
  left=4pt,
  right=4pt,
  top=1pt,
  bottom=4pt,
  drop shadow={#2!40, xshift=1.8pt, yshift=-1.8pt},
  title={#3},
  fonttitle=\small\bfseries\color{#2},
  attach boxed title to top center={yshift*=-\tcboxedtitleheight/2},
  boxed title style={
    colback=white,
    colframe=white,
    boxrule=0pt,
    left=3pt,
    right=3pt,
    top=0pt,
    bottom=0pt,
    sharp corners
  },
  overlay={%
    \fill[#2] 
      ([yshift=-15pt]frame.north west) -- 
      ([xshift=-4pt, yshift=-18.5pt]frame.north west) -- 
      ([yshift=-22pt]frame.north west) -- cycle;
  },
  #1
}

\newbox{\prepa@notebox}

\NewDocumentCommand{\prepa@makenote}{O{0pt} +m}{%
  \setbox\prepa@notebox=\vbox{%
    \hsize=\marginparwidth
    \textwidth=\marginparwidth
    \parindent=0pt
    \vskip #1\relax
    #2\par\kern0pt
  }%
  \dp\prepa@notebox=0pt
  \makenote*[margincol]{\box\prepa@notebox}%
}

\NewDocumentCommand{\idee}{O{0pt} +m}{%
  \prepa@makenote[#1]{%
    \begin{marginbox}{ideayellow}{\faLightbulb~ Idée}
      \footnotesize\raggedright\sloppy #2
    \end{marginbox}%
  }%
}

\NewDocumentCommand{\notedanger}{O{0pt} +m}{%
  \prepa@makenote[#1]{%
    \begin{marginbox}{dangerred}{\skull~ Danger !}
      \footnotesize\raggedright\sloppy #2
    \end{marginbox}%
  }%
}

\NewDocumentCommand{\marginenote}{O{0pt} m +m}{%
  \prepa@makenote[#1]{%
    \begin{marginbox}{vorange}{#2}
      \footnotesize\raggedright\sloppy #3
    \end{marginbox}%
  }%
}

% =============================================================================
% ENVIRONNEMENTS EXERCICES & CORRIGÉS
% =============================================================================
\newcounter{numexo}[chapitre]
\renewcommand{\thenumexo}{\thechapitre.\arabic{numexo}}

\newenvironment{exercice}[1][]{%
  \refstepcounter{numexo}%
  \phantomsection%
  \hypertarget{exo.\thenumexo}{}%
  \par\vspace{12pt}\noindent%
  \begingroup%
  \bfseries%
  \hyperlink{sol.\thenumexo}{\bfseries\scshape\Large\color{vorange!95!black}Exercice~\thenumexo}%
  \ifstrempty{#1}{}{ \textnormal{(#1)}}%
  \endgroup%
  \enspace\ignorespaces%
}{%
  \par\vspace{12pt}%
}

\newenvironment{correction}[1]{%
  \phantomsection%
  \hypertarget{sol.\thechapitre.#1}{}%
  \par\vspace{14pt}\noindent%
  {\color{vorange!70}\hrule height 1pt}%
  \vspace{8pt}\noindent%
  \begingroup%
  \bfseries%
  \hyperlink{exo.\thechapitre.#1}{\bfseries\scshape\Large\color{vorange!95!black}Corrigé de l'exercice~\thechapitre.#1}%
  \endgroup%
  \enspace\ignorespaces%
}{%
  \par\vspace{14pt}%
}
% =============================================================================
% EN-TÊTES ET PIEDS DE PAGE
% =============================================================================
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\thepage}
\fancyhead[R]{%
  \ifprepa@td%
    TD~\@numchapitre~-- \@titrechapitre%
  \else%
    Chapitre~\@numchapitre~-- \@titrechapitre%
  \fi%
}

\ifprepa@td
  \fancyhfoffset[R]{0pt}
\else
  \fancyhfoffset[R]{3cm}
\fi

\fancyfoot[L]{\scshape\@filiere}
\fancyfoot[C]{\scshape\@etablissement}
\fancyfoot[R]{\scshape Année \@annee}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

\fancypagestyle{premierepagechapitre}{%
  \fancyhf{}

  \fancyfoot[L]{\scshape\@filiere}
  \fancyfoot[C]{\scshape\@etablissement}
  \fancyfoot[R]{\scshape Année \@annee}
  
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\newcommand{\pagedegarde}{%
  \clearpage
  \newgeometry{top=2.4cm, bottom=2.4cm, left=2.5cm, right=2.5cm}%
  \pagestyle{empty}%
  
  \begin{tikzpicture}[remember picture, overlay]
    \draw[vorange, line width=2.5pt] (current page.north west) ++(1.4,-1.4) -- ++(2.8,0);
    \draw[vorange, line width=2.5pt] (current page.north west) ++(1.4,-1.4) -- ++(0,-2.8);
    \draw[vorange, line width=2.5pt] (current page.north east) ++(-1.4,-1.4) -- ++(-2.8,0);
    \draw[vorange, line width=2.5pt] (current page.north east) ++(-1.4,-1.4) -- ++(0,-2.8);

    \draw[vorange, line width=2.5pt] (current page.south west) ++(1.4,1.4) -- ++(2.8,0);
    \draw[vorange, line width=2.5pt] (current page.south west) ++(1.4,1.4) -- ++(0,2.8);
    \draw[vorange, line width=2.5pt] (current page.south east) ++(-1.4,1.4) -- ++(-2.8,0);
    \draw[vorange, line width=2.5pt] (current page.south east) ++(-1.4,1.4) -- ++(0,2.8);

    \draw[vorange!35, line width=0.6pt] 
      ([xshift=1.8cm, yshift=-1.8cm]current page.north west) 
      rectangle 
      ([xshift=-1.8cm, yshift=1.8cm]current page.south east);

    \node[anchor=north east, inner sep=0, opacity=0.2] 
      at ([xshift=-2cm, yshift=-2cm]current page.north east) {%
        \fontsize{150}{130}\selectfont\color{vorange}\chapitrenumfont\@numchapitre%
      };
  \end{tikzpicture}%

  \vspace*{0.2cm}
  \begin{center}
    {\huge\bfseries\scshape\color{vorange!95!black} \@filiere}\\[0.3em]
    {\Large\scshape\color{black!75} \@etablissement}\par
    \vspace{0.4cm}
    \tikz\draw[vorange, line width=1.5pt] (-2.5,0) -- (2.5,0);
  \end{center}

  \vfill

  \begin{center}
    {\LARGE\bfseries\scshape Chapitre~{\fontsize{48}{52}\selectfont\color{vorange}\chapitrenumfont\@numchapitre}}\\[0.8em]
    {\fontsize{32}{38}\selectfont\bfseries \@titrechapitre\par}
    
    \vspace{0.8cm}
    \begin{tikzpicture}
      \draw[vorange, line width=2pt] (-5,0) -- (5,0);
    \end{tikzpicture}
  \end{center}

  \vspace{0.8cm}

  \begin{center}
    \begin{tcolorbox}[
      width=0.88\linewidth,
      %arc=3mm,
      boxrule=1pt,
      colback=white,
      colframe=vorange!85!black,
      %leftrule=5pt,
      top=14pt, bottom=14pt, left=18pt, right=18pt,
      shadow={2pt}{-2pt}{0pt}{black!8}
    ]
      \centering
      {\Large\bfseries Polycopié rédigé par \textbf{L. Dehmas}, \textbf{C. Perry} \textit{et~al.}}\\[0.45em]
      {\large\itshape D'après les enseignements dispensés par \textbf{Yann Quibel}}\par
      \vspace{0.8em}
      {\color{vorange!30}\hrule height 0.6pt}\par
      \vspace{0.8em}
      {\normalsize\scshape\color{black!70} 
          Cours de mathématiques en maths spé
      }
    \end{tcolorbox}
  \end{center}

  \vfill

  \begin{center}
    {\large\bfseries\scshape Année \@annee\par}
    \vspace{0.15cm}
    {\small\color{black!60} Document composé sous \LaTeX{} -- Version du \today\par}
  \end{center}
  \vspace*{0.2cm}

  \clearpage
  \passerenmodecours
  \pagestyle{fancy}%
  \thispagestyle{premierepagechapitre}%
  \displaychapitrebanner
}

\newcommand{\displaychapitrebanner}{%
  \vspace*{-1cm}
  \noindent
  \ifprepa@td%
    \begin{minipage}{\textwidth}
      \parbox[b]{\dimexpr\textwidth-3cm\relax}{%
        \raggedright
        {\fontsize{24}{28}\selectfont\bfseries\scshape TD~:~\@titrechapitre\par}%
        \vspace{4pt}%
        \textcolor{vorange}{\rule{\linewidth}{1.5pt}}%
      }%
      \hfill
      \parbox[b]{2.5cm}{%
        \raggedleft
        \color{vorange}%
        \fontsize{80}{70}\selectfont
        \chapitrenumfont
        \@numchapitre
      }%
    \end{minipage}%
  \else%
    \makebox[\textwidth][l]{%
      \begin{minipage}{\dimexpr\textwidth+\marginparsep+\marginparwidth\relax}
        \parbox[b]{\dimexpr\linewidth-3.5cm\relax}{%
          \raggedright
          {\fontsize{24}{28}\selectfont\bfseries\scshape\@titrechapitre\par}%
          \vspace{4pt}%
          \textcolor{vorange}{\rule{\linewidth}{1.5pt}}%
        }%
        \hfill
        \parbox[b]{3cm}{%
          \raggedleft
          \color{vorange}%
          \fontsize{80}{70}\selectfont
          \chapitrenumfont
          \@numchapitre
        }%
      \end{minipage}%
    }%
  \fi%
  \par\vspace{0.5cm}
}

\newcommand{\restaurergeometrie}{%
  \clearpage
  \ifprepa@td
    \passerenmodeexos
  \else
    \passerenmodecours
  \fi
  \pagestyle{fancy}%
}

% =============================================================================
% COMMANDES MATHS & TITRES
% =============================================================================
\renewcommand{\tagform@}[1]{#1}
\renewcommand{\theequation}{}


\@addtoreset{section}{chapitre}
\@addtoreset{subsection}{section} 
\@addtoreset{subsubsection}{subsection}

\renewcommand{\thesection}{\thechapitre.\arabic{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}
\renewcommand{\thesubsubsection}{\thesubsection.\arabic{subsubsection}}

\setcounter{secnumdepth}{3}

\renewcommand*\l@section{\@dottedtocline{1}{1.5em}{2.5em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{4.5em}{3em}}

\newcommand{\l@chapitre}[2]{%
  \vspace{0.5em}%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \setlength\@tempdima{6em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries\large
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      {\textcolor{vorange}{#1}}\nobreak\
      \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
      \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi
  \vspace{0.2em}%
}

\providecommand{\toclevel@chapitre}{0}
\providecommand{\toclevel@section}{1}
\providecommand{\toclevel@subsection}{2}

\titleformat{\section}
  {\normalfont\LARGE\bfseries\color{vorange!95!black}}
  {\thesection}{1em}{}
  [\vspace{0.5em}]

\titlespacing*{\section}{-1.5em}{2ex plus 1ex minus .2ex}{1ex plus .2ex}

\titleformat{\subsection}
  {\normalfont\Large\bfseries}
  {\color{vorange!95!black}\thesubsection}{1em}{}
  [\vspace{0.3em}]

\titlespacing*{\subsection}{-2em}{2ex plus 1ex minus .2ex}{1ex plus .2ex}

\titleformat{\subsubsection}
  {\normalfont\large\bfseries}
  {\color{vorange!95!black}\thesubsubsection}{1em}{}
  [\vspace{0.3em}]

\titlespacing*{\subsubsection}{-1em}{2ex plus 1ex minus .2ex}{1ex plus .2ex}

\titlespacing*{\paragraph}{1.5em}{2ex plus 1ex minus .2ex}{1ex plus .2ex}

\newcommand{\chapitreintegral}[2]{%
  \clearpage
  \setchapitre{#1}%
  \gdef\@numchapitre{#1}%
  \gdef\@titrechapitre{#2}%
  \markboth{Chapitre #1 -- #2}{}%
  \addcontentsline{toc}{chapitre}{\protect\numberline{Chapitre #1}#2}%
  \newgeometry{top=2.8cm, bottom=2.8cm, left=2.8cm, right=2.8cm}%
  \pagestyle{empty}%
  \startcontents[chapters]%

  \vspace*{0.6cm}%
  
  \begin{center}
    {\LARGE\scshape\bfseries Chapitre~{\fontsize{44}{48}\selectfont\color{vorange}\chapitrenumfont #1}}\\[0.6em]
    
    {\fontsize{26}{32}\selectfont\bfseries #2\par}
    
    \vspace{0.6cm}
    \begin{tikzpicture}
      \draw[vorange, line width=1.4pt] (-4.5,0) -- (4.5,0);
      \fill[vorange] (-0.35,-0.06) rectangle (0.35,0.06);
    \end{tikzpicture}
  \end{center}

  \vspace{1.0cm}
  \nopagebreak

  \begin{center}
    {\large\bfseries\scshape\color{black!80} Table des matières\par}%
  \end{center}%
  \vspace{0.4cm}%
  \nopagebreak

  \begingroup
    \setlength{\leftskip}{0.06\textwidth}%
    \setlength{\rightskip}{0.06\textwidth}%
    \hypersetup{linkcolor=black}%
    \printcontents[chapters]{}{1}{\setcounter{tocdepth}{2}}%
    \par
  \endgroup
  
  \vfill%
  \clearpage
  \passerenmodecours
  \pagestyle{fancy}%
  \thispagestyle{premierepagechapitre}%
}

\endinput
