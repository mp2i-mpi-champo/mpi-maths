## Aide 
La page [wikipedia aide au formules tex](https://fr.wikipedia.org/wiki/Aide:Formules_TeX) contient à peu près tout ce qui est nécessaire pour écrire du latex. 

## Environnements personalisés 
Il existe un certain nombre d'environnements personalisés à destination des 
propositions, théorèmes, ... 

Voici un exemple d'utilisation pour une proposition : 

```latex
\begin{proposition}{Titre de la proposition (facultatif)}{}
    Contenu de la proposition 
\end{proposition}
```

Il est nécessaire de mettre les accolades contenant le titre et les accolades vides, sinon le début du contenu de la proposition sera coupé. 

Il existe également les environnements "idée" pour mettre par exemple une idée du principe général des preuves. Ceux si cont affichés dans la marge au niveau de l'endroit où ils sont appelés. Ils s'utilisent comme suit : 
```latex
\idee{
    Idée de la preuve. 
}
```

Pour les preuves, l'environnement utilisé n'est pas de moi. Il se trouve dans un des package utilisés. 

```latex
\begin{proof}
    Contenu de la preuve. 
\end{proof}
```

Par défaut, le package affiche "Démonstration", puis le contenu fournit. Il est possible de modifier ce titre de cette façon : 

```latex
\begin{proof}[Titre]
    Contenu de la preuve. 
\end{proof}
```

"Titre" sera alors affiché à la place de "Démonstration". 

Un autre environnement sympa sont les notes dans la marge. Il y en a une qui est prédéfini, celle de danger, qui s'utilise ainsi : 
```latex
\danger{Contenu de la note dans la marge}
```

Et un autre environnement plus générique : 
```latex
\marginenote{Titre de la note}{Contenu de la note}
```

Il est généralement conseillé, lorsque ces environnements sont utilisés au milieu du texte, de leur ajouter des `\lvspace` ou `\avspace` par la suite, qui sont des commandes expliquées dans le paragraphe suivant.

## Titres 
Il existe différents niveaux de titres, dans cet ordre : 

```latex
\section{grand titre}
\subsection{taille en dessous}
\subsubsection{Encore plus petit}
\paragraph{Plus vraiment un titre...}
```

Seuls les deux premiers sont affichés dans la table des matières. La profondeur de la table des matières peut être modifiée dans le fichier `prépacours.cls`, en augmentant ou diminuant le paramètre "tocdepth". Le fait que les subsubsection ne soient pas numérotés est une des personalisations de la classe.

Pour afficher un titre sans que celui-ci n'apparaisse dans la table des matière, vous pouvez ajouter une étoile : 

```latex
\section*{Titre non numéroté}
```

Et de même pour les autres niveaux de titre.

## Commandes personalisées 
J'ai également un fichier de raccourcis pour gagner du temps lorsque je tape, réunis dans le fichier `raccourcis.sty`. En voici les principaux : 

Pour les ensembles de nombres : 
```latex
\C, \R, \Q, \Z, \N
```
permettent d'obtenir le rendu des ensembles de nombres. 

Pour les fonctions : 
```latex
\fonction{nom de la fonction}{ensemble de départ}{ensemble d'arrivée}{variable}{formule}
```

Par exemple pour la fonction carré dans R : 
```latex
\fonction{f}{\R}{\R}{x}{x^2}
```

Lorsqu'il n'y a qu'un seul élément dans les accolades, celles ci peuvent être supprimées. Pour la fonction définie précédemment, on obtient : 
```latex
\fonction f \R \R x {x^2}
```

Les raccourcis suivants permettent eux de laisser un espace vertical "large", "average" (qui aurait plutôt du s'appeler medium) ou "small", en utilisant les commandes suivantes : 

```latex
\lvspace 
\avspace 
\svspace 
```

La hauteur de l'espace vertical créé peut être modifiée dans le fichier des raccourcis, et d'autres peuvent également être ajoutés. 

Un autre raccourci utile est `\uindent`. Celui-ci permet de créer un text qui va être souligné et indenté, avec un espace au dessus de celui-ci. Il est conseillé d'utiliser une commande pour laisser de l'espace vertical en dessous de celui-ci. 

J'ai créé de nombreux raccourcis pour tous les opérateurs classiques comme Vect, Ker, Sp, rg, cov, ... Vous pouvez retrouver la liste exhaustive dans le fichier `raccourcis.sty`. 

## Métadonnées
Avant de pouvoir compiler le fichier avec la classe, il faut lui fournir un certain nombre de métadonnées, qui sont les suivantes : 

```latex
\annee{2025-2026}
\filiere{MPI / MPI*}
\etablissement{Lycée Champollion}
\chapitre{Numéro du chapitre (NECESSAIREMENT UN NOMBRE)}{titre du chapitre}
```

La majorité de celles-ci sont réunis dans un fichier qui est simplement inclus au début de chaque chapitre, pour ne pas tout retaper à chaque fois.

## Présentation 
Pour que la page de garde avec la table des matières apparaisse, ainsi que la première page de cours avec le titre en grand, il faut utiliser la commande `\pagedegarde` au tout début du contenu du document. Cela donne donc quelque chose du type : 

```latex
% métadonnées et importations

\begin{document}

\pagedegarde 

% contenu latex 

\end{document}
```

## Exercies et corrections 
Il y a également des environnements pour inclure des exos et leur correction. Pour cela, il existe des commandes permettant de passer du mode exos au mode cours, qui sont : 
```latex
\passerenmodeexos
\passerenmodecours
```

Les différents modes sont uniquement destinés à modifier la taille des en tête et des marges (normalement). 

Il y a alors des environnement personalisés pour les exercies : 
```latex
\begin{exercice}
    Contenu de l'exo
\end{exercice}
```

et pour leur correction : 

```latex
\begin{correction}{nb}
    contenu correction
\end{correction}
```

Le champ "nb" permet de faire un lien vers l'exercice numéro "nb", pour ensuite permettre de passer de l'un à l'autre par un système de liens cliquables.

## Index
J'ai également créé un index, qui apparait à la fin du document, pour accéder aux notions importantes rapidement. Pour ajouter un nouvel élément dans l'index, il suffit d'utiliser cette commande : 
```latex
\index{Notion}
```

### Spécificités 
On peut ajouter des éléments et des sous éléments, associés à un même élément. Pour cela, on met un `!`.
Par exemple, groupe et anneau sont tout deux associés à morphisme de cette façon : 
```latex
\index{Morphisme!d'anneau}
\index{Morphisme!de groupe}
```

Et si un terme contient un accent, pour le respect de l'ordre alphabétique, il faut utiliser cette syntaxe : 
```latex
\index{Version sans accent@Version avec accents}
```

## Index
J'ai également créé un index, qui apparait à la fin du document, pour accéder aux notions importantes rapidement. Pour ajouter un nouvel élément dans l'index, il suffit d'utiliser cette commande : 
```latex
\index{Notion}
```

### Spécificités 
On peut ajouter des éléments et des sous éléments, associés à un même élément. Pour cela, on met un `!`.
Par exemple, groupe et anneau sont tout deux associés à morphisme de cette façon : 
```latex
\index{Morphisme!d'anneau}
\index{Morphisme!de groupe}
```

Et si un terme contient un accent, pour le respect de l'ordre alphabétique, il faut utiliser cette syntaxe : 
```latex
\index{Version sans accent@Version avec accents}
```
