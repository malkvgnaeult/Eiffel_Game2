# Installation d'EiffelStudio
1. Cliquez sur ce lien: https://account.eiffel.com/downloads
2. Téléchargez la version la plus récente finissant par '64.msi'.
3. Allez dans vos téléchargments dans l'explorateur de fichier.
4. Double-cliquez sur le fichier que vous venez de télécharger.
5. Si vous avez une alerte Windows disant que le logiciel peut être dangereux, cliquez sur 'plus d'information', puis sur 'exécuter quand même'. Un wizard d'installation d'EiffelStudio devait s'ouvrir.
6. <img width="616" height="399" alt="image" src="https://github.com/user-attachments/assets/6e623e95-a259-4fbd-ac92-f0ed3da26be2" />

7. Cliquez sur 'next'.
8. Cliquez sur 'Agree'.
9. Choisissez le chemin où vous voulez installer EiffelStudio. Je vous conseille de garder l'emplacement par défaut.
   <img width="622" height="396" alt="image" src="https://github.com/user-attachments/assets/26054a01-48f3-43b4-b4f3-c7ffc7fbad95" />

10. Choisissez la langue que vous voulez.
<img width="620" height="402" alt="image" src="https://github.com/user-attachments/assets/2347127b-43c6-4309-96cf-8fef248bfdd4" />

12. Cochez l'option 'Create a shortcut on desktop' si ça vous intéresse.

13. Cliquez sur 'Install'
<img width="623" height="394" alt="image" src="https://github.com/user-attachments/assets/5bfd53ad-9911-47f5-9d85-9468afa13fab" />
14.Cliquez sur 'finish' unef ois l'installation terminée.


# Installation de la librarire Eiffel_Game2 version développement
Vous devez avoir L'IDE EiffelStudio d'installé pour pouvoir utiliser cette librairie.
1. Créez un répertoire dans lequel cloner le projet.
2. Appelez-le 'game2'.
3. Faites 'git clone --recursive https://github.com/tioui/Eiffel_Game2.git game2' afin de clone le repo.
4. Faites un lien symbolique de votre répertoire 'game2' au répertoire 'contrib/library' d'EiffelStudio avec la commande suivante : mklink "C:\Program Files\Eiffel Software\EiffelStudio 19.05 GPL\contrib\library\game2" "C:\<votre chemin vers 'game2'>game2".
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
2. Copiez tous les DLLs le répertoire 'game2/C_lib_win/DLL32' ou 'game2/C_lib_win/DLL64'.
3. Collez tous les Dlls précédemment copiés dans le répertoire de l'exemple que vous voulez exécuter.
4. Double-cliquez sur le fichier avec l'extension 'ecf' du répertoire de votre exemple. Ce fichier a généralement le même nom que le répertoire.

# Tester le test de manette de jeu
Note: Votre manette doit être branché avant de lancer le projet afin d'être détectée.
Ce test consiste à tester les inputs de la manette branchée. La valeur de la position du joystick gauche est seulement détecté lors de l'appuie d'un bouton.

1. Ouvrir le dossier 'gamepad_test' dans la branche 'documentation'. Le dossier est la racine de 'game2'.
2. Double-cliquez le fichier 'game.ecf'.
3. Une fois le projet ouvert et compilé, cliquez sur 'Run'.

# Description des issues

## Ajouter Audio_video dans le project wizard
J’ai commencé par apprendre à utiliser EiffelBuild, un outil permettant de générer des interfaces graphiques en Eiffel. Louis m’a présenté rapidement les fonctionnalités essentielles dont j’aurais besoin pour faire sur cette issue. Cela m’a permis de comprendre les bases, mais plusieurs éléments restaient encore flous au moment de commencer l’implémentation étant donné que je n'était pas encore particulièrement familier avec la structure de Eiffel_Game2.

Pour créer la case à cocher Audio_video, je me suis appuyé sur les cases déjà existantes. Toutefois, je n’avais jamais vu les constantes définissant leur état par défaut et elles n’apparaissaient même pas dans la liste des constantes de l’application. Ce n’est qu’en discutant avec Louis en essayant de résoudre un problème d’affichage qui empêchait la case que je voulais ajouter d'apparaitre, que j’ai découvert qu'il fallait ajouter cette variable à travers EiffelBuild. Cette situation a ajouté une difficulté supplémentaire, d’autant plus que je n’étais toujours pas familier avec la structure interne de la librairie Eiffel_Game2, ce qui compliquait la navigation et la compréhension du code.

J’ai ensuite ajouté le code nécessaire pour intégrer la librairie Audio_video. Cependant, chaque fois que je pensais avoir terminé, je découvrais qu'il manquait un élément ou un comportement inattendu. J’ai fini par réaliser que j’avais placé du code dans des sections réservées aux librairies nécessitant un controller, ce qui provoquait des erreurs de compilation externe en C. L’erreur venait du fait que je m’étais basé sur la librairie audio, alors que j’aurais dû suivre l’exemple de audio_sound, la seule autre librairie sans controller. À un moment, j’ai même cru qu’il fallait créer un controller pour Audio_video, mais les controllers existants étant très différents les uns des autres, donc, je n'avais aucune idée de la façon à procéder pour en ajouter un. Heureusement, je n'ais pas eu à faire ça finalement.

Pour finir, pour que l’intégration fonctionne correctement, j’ai dû renommer un fichier, ce qui a finalement permis au système de reconnaître la librairie comme prévu. Enfin, j’ai dû exécuter un 'finish_freezing -library' directement dans le dossier 'C_lib' de la librairie Audio_video, car certains fichiers compilés manquaient et empêchaient la compilation complète.

## Ajouter une gamepad_library à Eiffel_Game2
J’ai passé un bon moment à lire la documentation de SDL afin de comprendre son fonctionnement. Malgré ces lectures, certains aspects restaient encore difficiles à saisir. Au début, j’avais créé des wrappers pour des fonctions de SDL3, mais Eiffel_Game2 repose en réalité sur SDL2. Cela a provoqué une longue liste d’erreurs lors de la première compilation d’un projet, notamment parce que SDL2 reconnaît Gamecontroller mais pas Gamepad.

La quantité de code à produire était beaucoup plus importante que prévu. J’ai dû implémenter la gestion des événements liés aux manettes, comme la détection d’un appareil connecté ou retiré, l’appui sur un bouton, ou encore les changements de position des axes, qui correspondent aux joysticks et aux gâchettes. Pour comprendre comment connecter une manette et gérer ses événements dans un jeu, je m’étais appuyé sur un tutoriel en C et j’ai tenté de reproduire la logique en Eiffel. Cela m’a obligé à modifier la portée de certaines méthodes pour que tout fonctionne correctement.

À un moment, j’ai réalisé que j’avais complètement oublié d’implémenter les joysticks, car SDL les désigne sous le terme 'axis'. Je pensais au départ que cela faisait référence au gyroscope de la manette. Pour corriger cela, j'ai implémenté les fonctions correspondantes permettant d'obtenir la valeur d'un 'axis' d'une manette.

Comme je n’avais pas une vision claire de ce qu’il fallait faire, j’avais souvent l’impression d’avancer dans le noir. J’ai demandé à Louis des indications sur ce qu’il souhaitait pour la librairie de gestion des manettes, mais il m’a simplement répondu qu’il ne fallait pas « réinventer la roue » et qu’il me laissait proposer une solution. Cette liberté ajoutait une certaine pression, car je devais trouver une approche cohérente sans modèle parfaitement défini.

Il me reste encore à tester certains événements, notamment la détection d’un appareil branché ou retiré et les événements liés aux 'axis' afin de m’assurer que l’ensemble du système fonctionne correctement dans toutes les situations.
