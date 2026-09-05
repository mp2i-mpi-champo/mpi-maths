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
\RequirePackage{marginnote}
\RequirePackage{needspace}
\RequirePackage{atbegshi}
\RequirePackage[normalem]{ulem}
\RequirePackage{etoolbox}
\RequirePackage{pgfplots}
\RequirePackage{titletoc}
\RequirePackage{enumitem}
\RequirePackage{ifthen}

\setmainfont{Libertinus Serif}[
  Ligatures=TeX,
  Numbers=OldStyle
]
\setsansfont{Libertinus Sans}[Ligatures=TeX]
\setmonofont{Libertinus Mono}
\setmathfont{Libertinus Math}

\setcounter{tocdepth}{2} 

% =============================================================================
% CONFIGURATION GÉOMÉTRIE
% =============================================================================
\geometry{
  top=3cm,
  bottom=2cm,
  left=2cm,
  right=5cm,
  marginparwidth=3.5cm,
  marginparsep=0.5cm,
  headheight=30pt
}

\setlength{\parindent}{0pt}
\setlength{\parskip}{0.3em}

\newcommand{\passerenmodecours}{%
  \clearpage
  \newgeometry{
    top=3cm,
    bottom=2cm,
    left=2cm,
    right=5cm,
    marginparwidth=3.5cm,
    marginparsep=0.5cm,
    headheight=30pt
  }%
  \fancyhfoffset[R]{\dimexpr\marginparsep+\marginparwidth\relax}%
}

\newcommand{\passerenmodeexos}{%
  \clearpage
  \newgeometry{
    top=3cm,
    bottom=2.5cm,
    left=2cm,
    right=2cm,
    headheight=30pt
  }%
  \fancyhfoffset[R]{0pt}%
}

\ifprepa@td
  \passerenmodeexos
\else
  \passerenmodecours
\fi
% =============================================================================
% COULEURS
% =============================================================================
\definecolor{vorange}{RGB}{245, 130, 32}
\definecolor{bg_theoreme}{RGB}{255, 237, 222}
\definecolor{bg_def_start}{RGB}{255, 237, 222}

\definecolor{ideayellow}{RGB}{230, 160, 0}
\definecolor{dangerred}{RGB}{220, 40, 40}


\definecolor{exobg}{RGB}{245,247,250}
\definecolor{exoframe}{RGB}{100,110,120}

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
\newcommand{\auteur}[1]{\gdef\@auteur{#1}}

\newcommand{\@numchapitre}{}
\newcommand{\@titrechapitre}{}
\newcommand{\@annee}{}
\newcommand{\@filiere}{}
\newcommand{\@etablissement}{}
\newcommand{\@auteur}{}

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

\setlist[itemize,1]{label=\footnotesize$\triangleright$}
\setlist[itemize,2]{label=\footnotesize$\char"25CA\relax$}
\setlist[itemize,3]{label=\footnotesize$\square$}
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
      drop shadow={vorange!40, xshift=1.8pt, yshift=-1.8pt},
      left=8pt,
      right=8pt,
      top=6pt,
      bottom=6pt,
      breakable,
      fonttitle=\bfseries\upshape\color{vorange},
      theorem style=plain,
      separator sign={\textnormal{\upshape~:~}},
      terminator sign={},
      description font=\normalfont\upshape,
      description color=black,
    },
    vexstyle/.style={
      enhanced,
      breakable,
      sharp corners,
      width=\dimexpr\linewidth-1.8pt\relax,
      boxrule=0.4pt,
      colframe=black!18,
      colback=white,
      borderline west={1.8pt}{0pt}{vorange},
      left=8pt,
      right=8pt,
      top=8pt,
      bottom=7pt,
      fonttitle=\bfseries\color{vorange},
      attach boxed title to top left={yshift=0pt, xshift=0pt},
      boxed title style={
        sharp corners,
        boxrule=0.4pt,
        colframe=black!18,
        colback=white,
        borderline west={1.8pt}{0pt}{vorange},
        left=6pt,
        right=6pt,
        top=3pt,
        bottom=3pt,
      }
    }
}

\newtcbtheorem[use counter=coursenv, number within=chapitre]{definition}{Définition}{
  vbase,
  frame empty,
  colback=white,
  no shadow,
  interior style={left color=bg_def_start, right color=white},
  separator sign={~-- },
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
}{corrolllaire}

\newenvironment{exemple}[1][]{%
  \refstepcounter{coursenv}%
  \begin{tcolorbox}[
    vexstyle,
    title={Exemple \thecoursenv\ifblank{#1}{}{\textnormal{\upshape~(#1)}}}
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
\newtcolorbox{marginbox}[3][]{%
  enhanced,
  nobeforeafter,
  sharp corners,
  colback=white,
  colframe=#2,
  boxrule=0.6pt,
  width=\dimexpr\marginparwidth-1.8pt\relax,
  left=4pt,
  right=4pt,
  top=5pt,
  bottom=5pt,
  drop shadow={#2!40, xshift=1.8pt, yshift=-1.8pt},
  title={#3},
  fonttitle=\small\bfseries\color{#2},
  attach boxed title to top center={yshift=-\tcboxedtitleheight/2},
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

\newcommand{\idee}[2][0pt]{%
  \marginnote{%
    \vspace{#1}%
    \begin{marginbox}{ideayellow}{\faLightbulb~ Idée}
      \footnotesize\raggedright #2
    \end{marginbox}%
  }%
}

\newcommand{\notedanger}[2][0pt]{%
  \marginnote{%
    \vspace{#1}%
    \begin{marginbox}{dangerred}{\faSkullCrossbones~ Danger !}
      \footnotesize\raggedright #2
    \end{marginbox}%
  }%
}

\newcommand{\marginenote}[3][0pt]{%
  \marginnote{%
    \vspace{#1}%
    \begin{marginbox}{vorange}{#2}
      \footnotesize\raggedright #3
    \end{marginbox}%
  }%
}

% =============================================================================
% ENVIRONNEMENTS EXERCICES & CORRIGÉS
% =============================================================================
\newcounter{numexo}[chapitre]
\renewcommand{\thenumexo}{\thechapitre.\arabic{numexo}}

\tcbset{
  vexobase/.style={
    enhanced,
    sharp corners,
    boxrule=0.4pt,
    colframe=black!85,
    breakable,
    left=9pt,
    right=9pt,
    top=8pt,
    bottom=7pt,
  }
}

% Énoncé
\newtcolorbox{exercicebox}[2][]{%
  vexobase,
  colback=white,
  drop shadow={vorange!40, xshift=1.8pt, yshift=-1.8pt},
  fonttitle=\bfseries\upshape\color{vorange},
  title={Exercice #2\ifstrempty{#1}{}{ \textnormal{(#1)}}%
    \hfill~%
    \hyperlink{sol.#2}{\small\color{vorange!85!black}\faArrowRight~Voir corrigé}%
  },
  attach boxed title to top left={yshift=0pt, xshift=0pt},
  boxed title style={
    sharp corners,
    boxrule=0.4pt,
    colframe=black!85,
    colback=white,
    left=6pt,
    right=6pt,
    top=3pt,
    bottom=3pt,
  }
}

\newenvironment{exercice}[1][]{%
  \refstepcounter{numexo}%
  \phantomsection%
  \hypertarget{exo.\thenumexo}{}%
  \begin{exercicebox}[#1]{\thenumexo}%
}{%
  \end{exercicebox}%
}


% Corrigé
\newtcolorbox{correctionbox}[1]{%
  vexobase,
  colframe=vorange!85!black,
  colback=white,
  drop shadow={vorange!25, xshift=1.8pt, yshift=-1.8pt},
  fonttitle=\bfseries\upshape\color{vorange},
  title={Corrigé de l'exercice \thechapitre.#1~%
    \hfill%
    \hyperlink{exo.\thechapitre.#1}{\small\color{vorange}\faArrowUp~Retour à l'énoncé}%
  },
  attach boxed title to top left={yshift=0pt, xshift=0pt},
  boxed title style={
    sharp corners,
    boxrule=0.4pt,
    colframe=vorange!85!black,
    colback=white,
    left=6pt,
    right=6pt,
    top=3pt,
    bottom=3pt,
  }
}

\newenvironment{correction}[1]{%
  \phantomsection%
  \hypertarget{sol.\thechapitre.#1}{}%
  \begin{correctionbox}{#1}%
}{%
  \end{correctionbox}%
}

% =============================================================================
% EN-TÊTES ET PIEDS DE PAGE
% =============================================================================
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\thepage}
\fancyhead[R]{%
  \ifprepa@td%
    TD~\@numchapitre -- \@titrechapitre%
  \else%
    Chapitre~\@numchapitre -- \@titrechapitre%
  \fi%
}

\ifprepa@td
  \fancyhfoffset[R]{0pt}
\else
  \fancyhfoffset[R]{3cm}
\fi

\fancyfoot[L]{\@filiere}
\fancyfoot[C]{\@etablissement~\@annee}
\fancyfoot[R]{\@auteur}

\fancypagestyle{premierepagechapitre}{%
  \fancyhf{}
  \setlength{\headheight}{70pt}
  \ifprepa@td%
    \fancyhfoffset[R]{0pt}
    \fancyhead[L]{\parbox[b]{\dimexpr\textwidth-3.5cm\relax}{\raggedright\fontsize{24}{28}\selectfont\bfseries\color{vorange!90!black}TD~:~\@titrechapitre}}
  \else%
    \fancyhfoffset[R]{\dimexpr\marginparsep+\marginparwidth\relax}
    \fancyhead[L]{\parbox[b]{\dimexpr\textwidth+\marginparsep+\marginparwidth-3.5cm\relax}{\raggedright\fontsize{24}{28}\selectfont\bfseries\color{vorange!90!black}\@titrechapitre}}
  \fi%
  \fancyhead[R]{\parbox[b]{3cm}{\raggedleft\fontsize{50}{40}\selectfont\bfseries\color{vorange}\@numchapitre}}
  \renewcommand{\headrulewidth}{0.8pt}
  \renewcommand{\footrulewidth}{0pt}
}

\newcommand{\pagedegarde}{
  \newgeometry{top=3cm, bottom=3cm, left=3cm, right=3cm}
  \thispagestyle{empty}
  \begin{center}
    {\Huge \bfseries Chapitre~\@numchapitre{} -- \@titrechapitre \par}
  \end{center}
    \vspace{1cm}
    \tableofcontents
    \vfill
  \begin{center}
    {\Large Année \@annee \par}
    {\normalsize Version du \today \par}
  \end{center}
  \newpage
  \passerenmodecours
  \thispagestyle{premierepagechapitre}
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

% Formatage personnalisé pour les chapitres dans la table des matières
\newcommand{\l@chapitre}[2]{%
  \vspace{0.5em}%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \setlength\@tempdima{6em}% Largeur pour "Chapitre XX"
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

% Configuration hyperref pour le niveau chapitre
\providecommand{\toclevel@chapitre}{0}
\providecommand{\toclevel@section}{1}
\providecommand{\toclevel@subsection}{2}

\titleformat{\section}
  {\normalfont\LARGE\bfseries\color{vorange}}
  {\thesection}{1em}{}
  [\vspace{0.5em}]

\titlespacing*{\section}{-1.5em}{2ex plus 1ex minus .2ex}{1ex plus .2ex}

\titleformat{\subsection}
  {\normalfont\Large\bfseries}
  {\color{vorange}\thesubsection}{1em}{}
  [\vspace{0.3em}]

\titlespacing*{\subsection}{-3em}{2ex plus 1ex minus .2ex}{1ex plus .2ex}

\titleformat{\subsubsection}
  {\normalfont\large\bfseries}
  {\color{vorange}\thesubsubsection}{1em}{}
  [\vspace{0.3em}]

\titlespacing*{\subsubsection}{-2em}{2ex plus 1ex minus .2ex}{1ex plus .2ex}

\titlespacing*{\paragraph}{1.5em}{2ex plus 1ex minus .2ex}{1ex plus .2ex}

% Commande pour démarrer un chapitre dans le document intégral
% (sans page de garde ni table des matières propre au chapitre)
\newcommand{\chapitreintegral}[2]{%
  \clearpage
  \setchapitre{#1}%
  \gdef\@numchapitre{#1}%
  \gdef\@titrechapitre{#2}%
  \markboth{Chapitre #1 -- #2}{}%
  \addcontentsline{toc}{chapitre}{\protect\numberline{Chapitre #1}#2}%
  % Page de sommaire local en pleine largeur
  \newgeometry{top=3cm, bottom=3cm, left=3cm, right=3cm}%
  \thispagestyle{empty}%
  \startcontents[chapters]%
  \vspace*{1.5cm}%
  \begin{center}%
    {\Huge\bfseries\color{vorange!90!black} Chapitre {#1} : #2\par}%
    \vspace{1cm}%
    {\Large\bfseries\color{black!80} Table des matières\par}%
    \vspace{0.8cm}%
    \begin{minipage}{0.85\textwidth}%
      \printcontents[chapters]{}{1}{\setcounter{tocdepth}{2}}%
    \end{minipage}%
  \end{center}%
  \vfill%
  \clearpage
  \passerenmodecours
  \thispagestyle{premierepagechapitre}%
}

\endinput
