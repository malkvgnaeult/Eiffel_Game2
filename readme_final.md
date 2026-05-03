# Installation d'EiffelStudio
1. Cliquez sur ce lien: https://account.eiffel.com/downloads
2. Téléchargez la version la plus récente finissant par '64.msi'.
<img width="1322" height="202" alt="image" src="https://github.com/user-attachments/assets/481fa65d-7581-4464-8d44-f6787fa4bcb2" />

3. Allez dans vos téléchargments dans l'explorateur de fichier.
4. Double-cliquez sur le fichier que vous venez de télécharger.
5. Si vous avez une alerte Windows disant que le logiciel peut être dangereux, cliquez sur 'plus d'information', puis sur 'exécuter quand même'. Un wizard d'installation d'EiffelStudio devrait s'ouvrir.
6. <img width="616" height="399" alt="image" src="https://github.com/user-attachments/assets/6e623e95-a259-4fbd-ac92-f0ed3da26be2" />

7. Cliquez sur 'next'.
8. Cliquez sur 'Agree'.
9. Choisissez le chemin où vous voulez installer EiffelStudio. Je vous conseille de garder l'emplacement par défaut.
   <img width="622" height="396" alt="image" src="https://github.com/user-attachments/assets/26054a01-48f3-43b4-b4f3-c7ffc7fbad95" />

10. Choisissez la langue que vous voulez.
<img width="620" height="402" alt="image" src="https://github.com/user-attachments/assets/2347127b-43c6-4309-96cf-8fef248bfdd4" />

11. Cochez l'option 'Create a shortcut on desktop' si ça vous intéresse.

12. Cliquez sur 'Install'
<img width="623" height="394" alt="image" src="https://github.com/user-attachments/assets/5bfd53ad-9911-47f5-9d85-9468afa13fab" />

13.Cliquez sur 'finish' une fois l'installation terminée.


# Installation de la librarire Eiffel_Game2 version développement
Vous devez avoir L'IDE EiffelStudio d'installé pour pouvoir utiliser cette librairie.
1. Créez un répertoire dans lequel cloner le projet.
2. Appelez-le 'game2' et ouvrez une invite de commande depuis cet emplacement.
3. Faites 'git clone --recursive https://github.com/tioui/Eiffel_Game2.git game2' afin de clone le repo.
4. Faites un lien symbolique de votre répertoire 'game2' au répertoire 'contrib/library' d'EiffelStudio avec la commande suivante : mklink "C:\Program Files\Eiffel Software\EiffelStudio 19.05 GPL\contrib\library\game2" "C:\<votre chemin vers 'game2'>game2". À noter que le numéro de version d'EiffelStudio peut varie selon la version que vous avez installé.
5. Faites un 'git pull origin master' dans le répertoire 'game2' où vous avez cloné le projet afin d'être certain que vous êtes à jour. Il se peut que vous ayez à faire cette commande pour que cela fonctionne 'git config --global --add safe.directory 'C:/Program Files/Eiffel Software/EiffelStudio 19.05 GPL/contrib/library/game2''
6. Téléchargez ce fichier: https://github.com/tioui/Eiffel_Game2/raw/refs/heads/windows_build/C_libraries.zip.
7. Placez le répertoire 'C_lib_win' à la racine du répertoire 'game2' après avoir extrait le contenu du fichier.
8. Ouvrez un 'EiffelStudio command prompt'. Le meilleur moyen de faire cela d'appuyer sur la touche 'Windows' et de taper 'Eiffel' dans la barre de recherche.
<img width="1479" height="315" alt="image" src="https://github.com/user-attachments/assets/896f7f8c-9231-42f9-a322-8c7f4836d2db" />

9. Allez dans le répertoire 'game2/Clib' à l'aide de la commande 'cd contrib/library/game2/Clib'.
10. Une fois dans ce répertoire, exécutez la commande 'finish_freezing -library'.
11. Afin de vous assurer que tout fonctionne correctement, vous pouvez essayer de compiler un exemple de la librairie.

# Compiler un exemple
1. Choisissez un exemple dans 'game2/example'.
2. Copiez tous les DLLs du répertoire 'game2/C_lib_win/DLL32' ou 'game2/C_lib_win/DLL64'.
3. Collez tous les Dlls précédemment copiés dans le répertoire de l'exemple que vous voulez exécuter.
4. Double-cliquez sur le fichier avec l'extension 'ecf' du répertoire de votre exemple. Ce fichier a généralement le même nom que le répertoire.

# Tester le test de manette de jeu - Deprecated
Il est maintenant préférable d'utiliser l'exemple de manette de jeu qui a été fait en issue.
Note: Votre manette doit être branché avant de lancer le projet afin d'être détectée.
Ce test consiste à tester les inputs de la manette branchée. La valeur de la position d'un 'axis' est seulement détecté lors de l'appuie d'un bouton. Ce programme ne sert qu'à vérifier si la librairie arrive à comprendre les premiers événements testés. C'est assez rudimentaire comparé à l'issue d'exemple que je ferai par la suite.

1. Ouvrir le dossier 'gamepad_test' dans la branche 'documentation'. Le dossier est la racine de 'game2'.
2. Double-cliquez le fichier 'game.ecf'.
3. Une fois le projet ouvert et compilé, cliquez sur 'Run'.

# Description des issues

## Ajouter Audio_video dans le project wizard
### Description
Il faut ajouter une case à cocher dans le wizard de création de projet d'EiffelGame2 qui permet d'ajouter la librairie Audio_video à un projet lors de sa création.
### Déroulement
J’ai commencé par apprendre à utiliser EiffelBuild, un outil permettant de générer des interfaces graphiques en Eiffel. Louis m’a présenté rapidement les fonctionnalités essentielles dont j’aurais besoin pour faire sur cette issue. Cela m’a permis de comprendre les bases, mais plusieurs éléments restaient encore flous au moment de commencer l’implémentation étant donné que je n'était pas encore particulièrement familier avec la structure de Eiffel_Game2.

Pour créer la case à cocher Audio_video, je me suis appuyé sur les cases déjà existantes. Toutefois, je n’avais jamais vu les constantes définissant leur état par défaut et elles n’apparaissaient même pas dans la liste des constantes de l’application. Ce n’est qu’en discutant avec Louis en essayant de résoudre un problème d’affichage qui empêchait la case que je voulais ajouter d'apparaitre, que j’ai découvert qu'il fallait ajouter cette variable à travers EiffelBuild. Cette situation a ajouté une difficulté supplémentaire, d’autant plus que je n’étais toujours pas familier avec la structure interne de la librairie Eiffel_Game2, ce qui compliquait la navigation et la compréhension du code.

J’ai ensuite ajouté le code nécessaire pour intégrer la librairie Audio_video. Cependant, chaque fois que je pensais avoir terminé, je découvrais qu'il manquait un élément ou un comportement inattendu. J’ai fini par réaliser que j’avais placé du code dans des sections réservées aux librairies nécessitant un controller, ce qui provoquait des erreurs de compilation externe en C. L’erreur venait du fait que je m’étais basé sur la librairie audio, alors que j’aurais dû suivre l’exemple de audio_sound, la seule autre librairie sans controller. À un moment, j’ai même cru qu’il fallait créer un controller pour Audio_video, mais les controllers existants étant très différents les uns des autres, donc, je n'avais aucune idée de la façon à procéder pour en ajouter un. Heureusement, je n'ais pas eu à faire ça finalement.

Pour finir, pour que l’intégration fonctionne correctement, j’ai dû renommer un fichier, ce qui a finalement permis au système de reconnaître la librairie comme prévu. Enfin, j’ai dû exécuter un 'finish_freezing -library' directement dans le dossier 'C_lib' de la librairie Audio_video, car certains fichiers compilés manquaient et empêchaient la compilation complète.

## Ajouter une gamepad_library à Eiffel_Game2
### Description
Ajouter le support de manette de jeux vidéo à la libraire game_core de EiffelGame2.
### Déroulement Partie 1 (remise d'avancement)
J’ai passé un bon moment à lire la documentation de SDL afin de comprendre son fonctionnement. Malgré ces lectures, certains aspects restaient encore difficiles à saisir. Au début, j’avais créé des wrappers pour des fonctions de SDL3, mais Eiffel_Game2 repose en réalité sur SDL2. Cela a provoqué une longue liste d’erreurs lors de la première compilation d’un projet, notamment parce que SDL2 reconnaît Gamecontroller mais pas Gamepad.

La quantité de code à produire était beaucoup plus importante que prévu. J’ai dû implémenter la gestion des événements liés aux manettes, comme la détection d’un appareil connecté ou retiré, l’appui sur un bouton, ou encore les changements de position des axes, qui correspondent aux joysticks et aux gâchettes. Pour comprendre comment connecter une manette et gérer ses événements dans un jeu, je m’étais appuyé sur un tutoriel en C et j’ai tenté de reproduire la logique en Eiffel. Cela m’a obligé à modifier la portée de certaines méthodes pour que tout fonctionne correctement.

À un moment, j’ai réalisé que j’avais complètement oublié d’implémenter les joysticks, car SDL les désigne sous le terme 'axis'. Je pensais au départ que cela faisait référence au gyroscope de la manette. Pour corriger cela, j'ai implémenté les fonctions correspondantes permettant d'obtenir la valeur d'un 'axis' d'une manette.

Comme je n’avais pas une vision claire de ce qu’il fallait faire, j’avais souvent l’impression d’avancer dans le noir. J’ai demandé à Louis des indications sur ce qu’il souhaitait pour la librairie de gestion des manettes, mais il m’a simplement répondu qu’il ne fallait pas « réinventer la roue » et qu’il me laissait proposer une solution. Cette liberté ajoutait une certaine pression, car je devais trouver une approche cohérente sans modèle parfaitement défini.

Il me reste encore à tester certains événements, notamment la détection d’un appareil branché ou retiré et les événements liés aux 'axis' afin de m’assurer que l’ensemble du système fonctionne correctement dans toutes les situations.

### Déroulement Partie 2 (remise finale)
J'ai d'abord implémenté les événements liés aux 'axis', ce qui a heureusement été un succès puisque c'est très similaire à l'implémentation des événements des boutons.

 Ensuite, j'ai voulu testé le fonctionnement des événements de connexion et de déconnexion d'une manette. Malheureusement, à mon grand désarroi, la manette ne fonctionnait plus une fois qu'elle était branchée après avoir été débranchée. J'ai d'abord cru que l'événement de déconnexion devait être implémenté incorrectement, mais, en déboguant, je voyais bien que la manette était correctement déconnecté. De plus, la manette était détecté lors de la reconnexion, alors l'événement de connexion semblait correct, mais la manette ne pouvait plus envoyer d'événements d'appui de boutons ou de mouvement d'axes. J'ai donc décidé d'investiguer l'objet 'internal_controllers' qui est un CHAIN_INDEXABLE_ITERATOR. Je n'avais jamais travaillé avec ce type auparavant, alors j'ai dû m'informer d'abord, mais il n'y a pas énormément de documentation détaillée sur Eiffel. En somme, 'internal_controllers' est chargé de lister les manettes de jeu connectées. Cependant, j'ai fini par remarquer que, dans la fonction qui retire une manette de 'internal_controllers', le curseur de 'internal_controllers' était déplacé selon certaines conditions grâce à une boucle qui était supposée replacer toutes les manettes afin de n'avoir que des manettes connectés dans 'internal_controllers'. Je me suis donc dit qu'il était possible que l'un des 'if' soient erronés puisque cela pourrait causer une position incorrect du curseur de 'internal_gamepads' ce qui expliquerait donc le problème rencontré. J'ai donc dû analyser les 'if' pour trouvé lequel était problématique. J'ai fini par découvrir que c'était le premier 'if' qui était fautif. En effet, ce 'if' comparait une ancienne valeur d'ID de la manette avec l'ID recue par la fonction qui n'était plus le même que lors de la déconnexion. La solution était de mettre cette ID en cache pour pouvoir utiliser une valeur valide lors de la déconnexion. Ce problème a pris beaucoup de temps à régler, car il n'y avait aucun message d'erreur pour m'aider à trouver la cause ou quelle partie du code qui produisait le bogue. De plus, le bogue se trouvait dans une section qui a été fortement inspirée par le code de Louis pour le retrait d'un Joystick et manipulait un type que je n'avais jamais vu auparavant(CHAIN_INDEXABLE_ITERATOR). J'avais donc une certaine méconnaissance du comportement de ce code.

 Finalement, j'ai tenté d'implémenter le mapping. Cela n'a pas été difficile d'implémenter l'événement puisque c'est le même procédé que l'implémentation des autres événements. Cependant, le mapping ne semblait pas fonctionner. Je crois que c'est parce que le GUID de la manette était toujours un GUID zéro, soit un GUID invalide. Encore une fois, je n'avais aucun message d'erreur pour m'aider. J'ai passé un après-midi et une soiré à tester différentes causes au problème, mais je n'ai jamais trouvé quoi que ce soit qui soit proche de la réponse. Aucune des solutions possibles que j'ai testé n'a fonctionné. La fonction SDL qui mappe ma manette retournait toujours '-1' ce qui signifie que ç'à a échoué.

 Pourtant, à ma grande surprise, lorsque je présentait mon test de manette à mon enseignant, certains de mes boutons ne marchaient plus. Après la rencontre, j'ai investigué un peu et j'ai réalisé que la fonction de mapping était encore présente et qu'elle retournait toujours le même résultat d'invalidité, mais le mapping s'est fait quand même. Lorsque j'enlevais cette fonction, ma manette redevenait nomrale. Je n'ai absolument aucune idée pourquoi. Le GUID est invalide et la fonction SDL retourne un échec, mais la mapping se fait quand même. Malgré toutes les recherches que j'ai faites je n'ai jamais trouvé d'explication à cet étrange comportement.

## Ajouter un exemple pour la libraire de manette de jeu
### Description
Ajouter un exemple d'utilisation de support de manette de jeux dans le dossier d'exemple.

### Déroulement
Au départ, j'ai eu un peu de difficulté à me rappeler comment me servir de la librairie Eiffel_Game2, mais cela m'est revenu après un certains temps à essayer différentes fonctionalités.

Par la suite, j'ai commencé par dessiner un rectangle sur la fenêtre de jeu, mais j'ai dû le remplacer par une image d'un rectangle, car il n'était pas possible de faire tourner le rectangle, mais il y a une fonctionalité pour faire tourner une image. J'ai ensuite implémenté les différents mouvements du rectangle, soit le déplacement grâce au joystick gauche et la rotation grâce aux boutons d'épaules (LB et RB sur une manette xbox). J'ai ensuite dessiné un carré au milieu du rectangle qui se déplace avec celui-ci, mais ne tourne pas. J'ai ensuite fait en sorte que le carré change de couleur selon le bouton qui appuyé. Il n'y a que les quatre boutons à droite qui fonctionnent de cette façon puisque ce sont les seuls boutons qui sont colorés sur une manette xbox. 

Après, en testant mon logiciel, j'ai remarqué que le déplacement ne fonctionnait pas correctement lorsque l'on voulait se déplacer et rotationner en même temps. En effet, si les deux mouvements étaient actifs en même temps et que l'un des deux s'arrêtaient, les deux s'arrêtaient. Puisque les deux mouvements sont contrôlés par des 'axis', ils envoient leur instance d'un événement 'axis' au même endroit. J'ai donc dû séparer la gestion des ces deux mouvements selon l'ID reçu.

En testant à nouveau le déplacement, j'ai remarqué que les mouvements de diagonales étaient très peu fluides. Selon les recherches que j'avais faites, SDL utilise des deadzones rectangulaires, ce qui pourraient causer le manque de fluidité que j'ai remarqué. Je me suis donc informé afin de pouvoir faire des deadzones circulaires. Malheureusement, il y avait peu d'informations et d'exemple à ce sujet, peu importe le language de programmation utilisée. Je me suis fié aux quelques exemples moyennement utiles que j'ai trouvé et je les ai 'traduits' en Eiffel et adaptés à mon projet. Cela a pris énormément d'essais et d'erreurs afin de trouver la bonne version et réglé tous les petits trucs qui ne marchaient pas à chaque fois, mais j'ai fini par avoir des deadzones circulaires fonctionnelles. Cependant,  cela n'a même pas réglé le problème. J'ai donc passé encore plus de temps à analysé le code. J'ai fini par trouvé quelque chose qui semblait redondant dans le code. En effet, les fonctions de déplacements verticaux et horizontaux et la fonction 'update' dans la classe RECTANGLE modifiaient toutes le timestamp. J'ai donc retiré cette modification dans les fonctions de déplacement et le problème fût réglé. J'ai donc compris que la timestamp est réinitialisée séparément dans la fonction de déplacement vertical et horizontal, ce qui désynchronise les deux axes.
 J'ai ensuite testé avec les deadzones rectangulaires et cela fonctionnait à merveille. J'ai quand même laissé les deadzones circulaires, car le mouvement était légèrement plus fluide et il est possible de modifier la valeur de la deadzone selon les goûts du développeurs. Aussi, je n'avais pas envie que mes efforts soient complètement inutiles.

## Tests unitaires
### Description
Il fallait faire des tests unitaires pour tester ce que j'ai implémenté dans la libraire Eiffel_Game2.
À noter: Pour cette issue, j'ai du modifier le code dans gamecontroller, ce qui a amélioré la qualité du code à mon avis. C'est cette version qui devrait se retrouver dans Eiffel_Game2 si Louis approuve évidemment.
### Déroulement
Pour créer l'environnement de test, j'ai dû ajouter un 'target' dans le XML de 'gamecontroller.ecf'. C'est quelque chose que j'ai appris dans mon cours d'Orienté Objet2. Cependant, je n'arrivait pas créer une classe pour faire des tests. Après quelques recherches, j'ai fini par trouver que c'était parce que je ne pouvais pas créer une classe dans l'environnement de test directement. Il fallait que je passe par le wizard de création de test d'EiffelStudio dont j'avais complètement oublié l'existence. Pourtant, j'ai aussi dû m'en servir lors de mon cours d'Orienté Objet 2.

J'ai ensuite rapidement recnontré un autre problème. Je ne comprenais pas comment je pouvais tester des manipulations physiques d'une manette en exécutant des tests automatiques. Les recherches que j'ai faites ne m'ont pas du tout, car toutes les solutions possibles étaient beaucoup trop complexes ou ne s'appliquaient pas à ma situation. De plus, il me faudrait tester les événements SDL, mais c'est impossible, car ils sont dans un projet de type 'Library', ce qui empêche toutes exécutions. J'en ai donc conclu que je devais tester la classe 'engine' de mon exemple au lieu de tester directement la classe 'gamepad' et les autres classes pertinentes.

Puisque je ne peux pas directement tester le code dans la librairie de manette de jeux, j'ai décider de simuler en quelque sorte ces événements en déclenchant manuellement la fonction que aurait été appelée par leur événement correspondant.

Les tests eux-même n'ont pas été trop difficiles à faire. Il y a eu quelques embûches, mais rien qui n'est pas attendu lorsque l'on fait des tests unitaires. J'ai donc fait des tests pour chaque simulation d'événement soit appuyer sur un bouton, déplacer le rectangle avec le joystick et rotationner le rectangle avec les boutons 'triggers' ainsi que la connexion d'une manette et sa déconnexion. J'ai également les deadzones des 'axis' et un cas invalide de bouton.

 Cela couvre quand même tout mon code d'une certaine façon puisque sans tout le code produit dans les autres classes de la libraire 'game_core', les manettes de jeux ne fonctionneraient pas dans la classe 'Engine'. 
# Tester le projet
Voici comment tester le projet 'gamecontrollers':

1. Vous devez vous assurer d'être dans la branche 'gamepad_test_set'.
2. Allez dans votre répertoire 'game2' puis allez dans 'examples/gamecontroller'. Si vous ne vous rappelez plus où est votre répertoire, vous pouvez aller dans celui d'EiffelStudio grâce à ce chemin: "C:\Program Files\Eiffel Software\EiffelStudio 19.05 GPL\contrib\library\game2". N'oubliez pas de changer la version d'EIffelStudio par celle que vous avez si ce n'est celle-là.
3. Double-cliquez sur 'gamecontroller.ecf'.
4. Cette fenêtre devrait s'ouvrir:

<img width="273" height="303" alt="image" src="https://github.com/user-attachments/assets/893450d9-640d-45e6-a481-2b0151291bed" />

Vous devez sélectionner 'gamecontroller_tests'.

5. De cette façon, vous devriez avoir le dossier 'tests' dans l'onglet 'Groups'.

<img width="519" height="852" alt="image" src="https://github.com/user-attachments/assets/8f9dba3b-8753-42bf-b6bb-dd5c6013d833" />

Vous pouvez voir les tests en cliquant sur 'GAMEPAD_TEST_SET'.

6. Pour exécuter les tests, vous devez aller dans l'onglet 'AutoTest' que vous voyez en bas. Vous pourrez sélectionnez les tests que vous voulez exécuter et appuyez sur la flèche verte pour lancer les tests.

<img width="520" height="364" alt="image" src="https://github.com/user-attachments/assets/9b407132-fd84-41a3-984e-ba8c1bc5f019" />



