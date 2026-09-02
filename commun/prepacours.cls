\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{../commun/prepacours}[2025/06/15 Classe LaTeX unifiée Cours/Exos Prépa - Liens Corrigés]

\LoadClass[a4paper,11pt]{article}

% =============================================================================
% PACKAGES
% =============================================================================
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[french]{babel}
\RequirePackage{amsmath,amsthm,amssymb}
\RequirePackage{mathrsfs}
\RequirePackage{xcolor}
\RequirePackage[most]{tcolorbox}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{mathpazo}
\RequirePackage{hyperref}
\RequirePackage{tikz}
\RequirePackage{lmodern}
\RequirePackage{fontspec}
\RequirePackage{stmaryrd}
\RequirePackage{fontawesome5}
\RequirePackage{graphicx}
\RequirePackage{marginnote}
\RequirePackage{needspace}
\RequirePackage{atbegshi}
\RequirePackage[normalem]{ulem}
\RequirePackage{etoolbox}
\RequirePackage{pgfplots}
\RequirePackage{titletoc}
\RequirePackage{ifthen}


\setcounter{tocdepth}{2} % Profondeur de la table des matières

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
%\makeatletter
%\edef\marginnotetextwidth{\the\textwidth}
%\makeatother
\setlength{\parindent}{0pt}
\setlength{\parskip}{0.3em}

\newcommand{\passerenmodeexos}{%
  \newgeometry{top=3cm, bottom=2.5cm, left=2cm, right=2cm}%
  \fancyhfoffset[R]{0cm}%
}

\newcommand{\passerenmodecours}{%
  \restoregeometry%
  \fancyhfoffset[R]{3cm}%
}

% =============================================================================
% COULEURS
% =============================================================================
\definecolor{bluebox}{RGB}{36,113,200}%Actual bluebox
\definecolor{redbox}{RGB}{231,35,35}
\definecolor{greenbox}{RGB}{60,150,200}
\definecolor{sectionblue}{RGB}{13, 114, 202}
\definecolor{examplebar}{RGB}{0,0,0}
\definecolor{ideabar}{RGB}{255,165,0}
\definecolor{exobg}{RGB}{245,247,250}
\definecolor{exoframe}{RGB}{100,110,120}
\definecolor{orange_des_definitions}{RGB}{255, 236, 218}
\definecolor{orange_des_exemples}{RGB}{255, 145, 10}
\definecolor{sectionorange}{RGB}{255, 145, 10}
\definecolor{orange_des_theoremes}{RGB}{255, 229, 204}


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

% =============================================================================
% STYLES TCOLORBOX
% =============================================================================

\newboolean{vstyle}
\setboolean{vstyle}{false}

\tcbset{
  thmbase/.style={
    enhanced, boxrule=0.8pt, arc=2pt,
    left=6pt, right=6pt, top=6pt, bottom=6pt,
    fonttitle=\bfseries
  },
  enhanced,
  propstyle/.style={thmbase, colback=bluebox!5, colframe=bluebox},
  theoremstyle/.style={thmbase, colback=greenbox!5, colframe=greenbox},
  defstyle/.style={thmbase, colback=redbox!5, colframe=redbox}
}
\ifthenelse{\NOT \boolean{vstyle}}{%
	\newtcbtheorem[use counter=coursenv, number within=chapitre]{theoreme}{Théorème}{theoremstyle}{thm}
	\newtcbtheorem[use counter=coursenv, number within=chapitre]{proposition}{Proposition}{propstyle}{prop}
	\newtcbtheorem[use counter=coursenv, number within=chapitre]{corollaire}{Corollaire}{propstyle}{cor}
	\newtcbtheorem[use counter=coursenv, number within=chapitre]{definition}{Définition}{defstyle}{def}
	\newtcbtheorem[use counter=coursenv, number within=chapitre]{propriete}{Propriété}{propstyle}{propiete}

	\newtcolorbox{exemple}[1][]{
		enhanced, breakable, enhanced jigsaw, pad at break=2mm,
	  colback=white, colframe=white, boxrule=0pt,
	  left=8pt, right=0pt, top=6pt, bottom=6pt,
	  borderline west={2pt}{0pt}{examplebar},
	  title={},
	  before upper={\textbf{\color{examplebar}Exemple} \par\vspace{0.2em}},
	  #1
	}
}{%

	%[V Style

	\newtcbtheorem[use counter = coursenv, number within = chapitre]
						{proposition}{Proposition}
						{colframe = black,
						theorem style = plain,
						fonttitle = \bfseries,
						sharp corners,
						boxrule=.2mm,
						breakable,
						coltitle = orange!110,
						drop shadow = orange!48,
						smart shadow arc = false,
						colback = white}{}

	\newtcbtheorem[use counter = coursenv, number within = chapitre]
						{corollaire}{Corollaire}
						{colframe = black,
						theorem style = plain,
						fonttitle = \bfseries,
						sharp corners,
						boxrule=.2mm,
						breakable,
						coltitle = orange!110,
						drop shadow = orange!48,
						smart shadow arc = false,
						colback = white}{}



	\newtcbtheorem[use counter = coursenv, number within = chapitre]
						{theoreme}{Théorème}
						{colframe = black,
						sharp corners,
						breakable,
						theorem style = plain,
						fonttitle = \bfseries,
						coltitle = orange!90!black,
						boxrule = .2mm,
						drop shadow = orange!48,
						smart shadow arc = false,
						colback = orange_des_theoremes}{}

	\newtcbtheorem[use counter = coursenv, number within = chapitre]
						{definition}{Définition}
						{interior style = {left color = orange_des_definitions, right color = white},
						sharp corners,
						colback = white,
						breakable,
						coltitle = orange!90!black,
						boxrule = .2mm,
						fonttitle = \bfseries,
						theorem style = plain,
						colframe = orange_des_definitions
					}{}

	\newtcolorbox{exemple}[1][]{
	  enhanced,
	  breakable,
	  enhanced jigsaw,
	  pad at break=2mm,
	  colback=white,
	  coltitle = orange_des_exemples,
	  colbacktitle = white,
	  colframe=orange_des_exemples,
	  attach boxed title to top left = {yshift = 0mm, xshift = 0mm},
	  boxed title style = {sharp corners, boxrule = 0.1pt, borderline west={1pt}{0pt}{orange_des_exemples}},
	  boxrule=0.1pt,
	  left=8pt,
	  right=0pt,
	  top=6pt,
	  bottom=6pt,
	  borderline west={2pt}{0pt}{orange_des_exemples},
	  title={},
	  before upper={
		\textbf{\color{orange_des_exemples}Exemple}
		\par\vspace{0.2em}
	  },
	  #1
   }
	%V Style]
}

\ifthenelse{\boolean{vstyle}}{
	\newenvironment{theorement}[2]{%
		\begin{theoreme}{#1}{#2}%
	}{%
		\end{theoreme}%
	}
	\newenvironment{propositionnt}[2]{
		\begin{proposition}{#1}{#2}%
	}{%
		\end{proposition}%
	}

	\newenvironment{corollairent}[2]{
		\begin{corollaire}{#1}{#2}%
	}{%
		\end{corollaire}%
	}

\newenvironment{definitionnt}[2]{
		\begin{definition}{#1}{#2}%
	}{%
		\end{definition}%
	}

}{
	\newtcolorbox{theorement}[2][]{theoremstyle, fonttitle=\bfseries, title={Théorème~\refstepcounter{coursenv}\thecoursenv}, #1}
	\newtcolorbox{propositionnt}[2][]{propstyle, fonttitle=\bfseries, title={Proposition~\refstepcounter{coursenv}\thecoursenv}, #1}
	\newtcolorbox{corollairent}[2][]{propstyle, fonttitle=\bfseries, title={Corollaire~\refstepcounter{coursenv}\thecoursenv}, #1}
	\newtcolorbox{definitionnt}[2][]{defstyle, fonttitle=\bfseries, title={Définition~\refstepcounter{coursenv}\thecoursenv}, #1}
}

\theoremstyle{remark}
\newtheorem*{remarque}{Remarque}


\newcommand{\ampoule}{\includegraphics[height=1.2em]{ampoule.png}} 
\newcommand{\idee}[1]{%
  \needspace{4\baselineskip}%
  \vspace{-1.6em}%
  \marginnote{\strut}%
  \begin{tikzpicture}[remember picture,overlay]
    \node[
      anchor=north west,
      inner sep=0pt
    ] at
      ([xshift=16.5cm]current page.west |- 0,0)
    {%
      \begin{tcolorbox}[
        enhanced, colback=yellow!5, colframe=ideabar,
        boxrule=0.8pt, arc=2pt, left=4pt, right=4pt, top=4pt, bottom=4pt,
        width=3.5cm, fonttitle=\scriptsize\bfseries, title={\ampoule~Idée de la preuve},
        coltitle=white, colbacktitle=ideabar, breakable=false
      ]
        \scriptsize\raggedright #1
      \end{tcolorbox}%
    };
  \end{tikzpicture}%
}

\newcommand{\danger}[1]{%
  \needspace{4\baselineskip}%
  \vspace{-1.6em}%
  \marginnote{\strut}%
  \begin{tikzpicture}[remember picture,overlay]
    \node[
      anchor=north west,
      inner sep=0pt
    ] at
      ([xshift=16.5cm]current page.west |- 0,0)
    {%
      \begin{tcolorbox}[
        enhanced,
        colback=white,
        colframe=redbox,
        boxrule=0.8pt,
        arc=2pt,
        left=4pt,
        right=4pt,
        top=4pt,
        bottom=4pt,
        width=3.5cm,
        fonttitle=\scriptsize\bfseries,
        attach boxed title to top center={yshift=-\tcboxedtitleheight/2},
        boxed title style={
          size=normal,
          colframe=white,
          boxrule=0pt,
          left=3pt,
          right=3pt
        },
        title={\skull~ Attention !},
        coltitle=red,
        colbacktitle=white,
        breakable=false
      ]
        \scriptsize\raggedright #1
      \end{tcolorbox}%
    };
  \end{tikzpicture}%
}

\newcommand{\marginenote}[2]{%
  \needspace{4\baselineskip}%
  \vspace{-1.6em}%
  \marginnote{\strut}%
  \begin{tikzpicture}[remember picture,overlay]
    \node[
      anchor=north west,
      inner sep=0pt
    ] at
      ([xshift=16.5cm]current page.west |- 0,0)
    {%
      \begin{tcolorbox}[
        enhanced,
        colback=white,
        colframe=bluebox,
        boxrule=0.8pt,
        arc=2pt,
        left=4pt,
        right=4pt,
        top=4pt,
        bottom=4pt,
        width=3.5cm,
        fonttitle=\scriptsize\bfseries,
        attach boxed title to top center={yshift=-\tcboxedtitleheight/2},
        boxed title style={
          size=normal,
          colframe=white,
          boxrule=0pt,
          left=2pt,
          right=2pt
        },
        title={#1},
        coltitle=sectionblue,
        colbacktitle=white,
        breakable=false
      ]
        \scriptsize\raggedright #2
      \end{tcolorbox}%
    };
  \end{tikzpicture}%
}

% =============================================================================
% ENVIRONNEMENTS EXERCICES & CORRECTIONS (CORRIGÉS)
% =============================================================================
\newcounter{numexo}[chapitre]
\renewcommand{\thenumexo}{\arabic{numexo}}

% Boîte Exercice interne
\newtcolorbox{exercicebox}[1][]{
  enhanced,
  colback=exobg, colframe=exoframe,
  coltitle=white, fonttitle=\bfseries\large,
  title={Exercice \thenumexo},
  attach boxed title to top left={xshift=5mm, yshift=-3mm},
  boxed title style={colback=exoframe, sharp corners},
  boxrule=0.5pt, top=10pt, breakable,
  #1
}

% Environnement Exercice
\newenvironment{exercice}{
  \refstepcounter{numexo}
  \phantomsection % Assure une ancre correcte
  % Cible unique : exo.CHAPITRE.NUMERO (ex: exo.9.1)
  \hypertarget{exo.\arabic{chapitre}.\arabic{numexo}}{} 
  \begin{exercicebox}[title={Exercice \thenumexo \hfill \hyperlink{sol.\arabic{chapitre}.\arabic{numexo}}{\small \faArrowRight~Voir correction}}]
}{
  \end{exercicebox}
}

% Boîte Correction interne (Argument MANDATOIRE cette fois pour éviter les erreurs)
\newtcolorbox{correctionbox}[1]{
  enhanced,
  colback=white, colframe=sectionblue,
  coltitle=sectionblue, fonttitle=\bfseries\large,
  title={Correction Exercice #1},
  detach title,
  before upper={%
    \phantomsection % Assure une ancre correcte
    % Cible unique : sol.CHAPITRE.NUMERO (utilise l'argument #1 donné par l'utilisateur)
    \hypertarget{sol.\arabic{chapitre}.#1}{}%
    \textbf{\textcolor{sectionblue}{\faPen~Correction Exercice #1}}%
    \hfill \hyperlink{exo.\arabic{chapitre}.#1}{\small \faArrowUp~Retour énoncé}\par\vspace{0.5em}\hrule\vspace{0.5em}%
  },
  boxrule=0pt, leftrule=3pt, sharp corners, breakable,
}

% Wrapper pour Correction
\newenvironment{correction}[1]{
  \begin{correctionbox}{#1}
}{
  \end{correctionbox}
}

% =============================================================================
% EN-TÊTES ET PIEDS DE PAGE
% =============================================================================
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\thepage}
\fancyhead[R]{Chapitre~\@numchapitre{} -- \@titrechapitre}
\fancyhfoffset[R]{3cm} 

\fancyfoot[L]{\@filiere}
\fancyfoot[C]{\@etablissement}
\fancyfoot[R]{\@auteur}

\fancypagestyle{premierepageschapitre}{%
  \fancyhf{}
  \setlength{\headheight}{70pt}
  \fancyhead[L]{\parbox[c][70pt][c]{12cm}{\fontsize{24}{28}\selectfont\bfseries\raggedright\@titrechapitre}}
  \fancyhead[R]{\parbox[c][70pt][c]{3cm}{\raggedleft\fontsize{50}{40}\selectfont\bfseries\color{sectionblue}\@numchapitre}}
  \renewcommand{\headrulewidth}{0.8pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhfoffset[R]{3cm}
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
  \thispagestyle{premierepageschapitre}
}

\newcommand{\restaurergeometrie}{%
  \clearpage
  \passerenmodecours
  \pagestyle{fancy}
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
      {\textcolor{sectionblue}{#1}}\nobreak\
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
  {\normalfont\LARGE\bfseries\color{sectionblue}}
  {\thesection}{1em}{}
  [\vspace{0.5em}]

\titlespacing*{\section}{-1.5em}{2ex plus 1ex minus .2ex}{1ex plus .2ex}

\titleformat{\subsection}
  {\normalfont\Large\bfseries}
  {\color{sectionblue}\thesubsection}{1em}{}
  [\vspace{0.3em}]

\titlespacing*{\subsection}{-3em}{2ex plus 1ex minus .2ex}{1ex plus .2ex}

\titleformat{\subsubsection}
  {\normalfont\large\bfseries}
  {\color{sectionblue}\thesubsubsection}{1em}{}
  [\vspace{0.3em}]

\titlespacing*{\subsubsection}{-2em}{2ex plus 1ex minus .2ex}{1ex plus .2ex}

\titlespacing*{\paragraph}{1.5em}{2ex plus 1ex minus .2ex}{1ex plus .2ex}

% Commande pour démarrer un chapitre dans le document intégral
% (sans page de garde ni table des matières propre au chapitre)
\newcommand{\chapitreintegral}[2]{%
  \clearpage
  \passerenmodecours % S'assure d'être en géométrie "Cours" (avec marge)
  \setchapitre{#1}%
  \gdef\@numchapitre{#1}%
  \gdef\@titrechapitre{#2}%
  \markboth{Chapitre #1 -- #2}{}%
  % Marquer le début du contenu pour titletoc
  \startcontents[chapters]%
  % Page de table des matières sans en-tête ni pied de page
  \newgeometry{
    top=2cm,
    bottom=3cm,
    left=3cm,
    right=3cm
  }
  \thispagestyle{empty}%
  \vfill
  \begin{center}
    {\Huge\bfseries Chapitre {#1} : #2\par}
    \vspace{0.5cm}
    {\Large\bfseries Table des matières\par}
    \vspace{0.5cm}
    \begin{minipage}{0.8\textwidth}
      % Affiche uniquement sections (niveau 1) et subsections (niveau 2)
      \printcontents[chapters]{}{1}{\setcounter{tocdepth}{2}}
    \end{minipage}
  \end{center}
  \vfill
  \restaurergeometrie % Restaure la géométrie "Cours" pour le contenu
  \clearpage
  % Ajouter une entrée dans la table des matières globale
  \addcontentsline{toc}{chapitre}{\protect\numberline{Chapitre #1}#2}%
  % Appliquer le style d'en-tête spécial pour la première page
  \thispagestyle{premierepageschapitre}%
  
}

\endinput
