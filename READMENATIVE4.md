# Installation de la librarire Eiffel_Game2 version développement
Vous devez avoir L'IDE EiffelStudio d'installé pour pouvoir utiliser cette librairie.
1. Créez un répertoire dans lequel cloner le projet.
2. Appelez-le 'game2'.
3. Faites 'git clone --recursive https://github.com/tioui/Eiffel_Game2.git game2' afin de clone le repo.
4. Faites un lien symbolique de votre répertoire 'game2' au répertoire 'contrib/library' d'EiffelStudio avec la commande suivante mklink "C:\Program Files\Eiffel Software\EiffelStudio 19.05 GPL\contrib\library\game2" "C:\<votre chemin vers 'game2'>game2".
5. Faites un 'git pull origin master' dans le répertoire 'game2' où vous avez cloné le projet afin d'être certain que vous êtes à jour. Il se peut que vous ayez à faire cette commande pour que cela fonctionne 'git config --global --add safe.directory 'C:/Program Files/Eiffel Software/EiffelStudio 19.05 GPL/contrib/library/game2''
6. Téléchargez ce fichier: https://github.com/tioui/Eiffel_Game2/raw/refs/heads/windows_build/C_libraries.zip.
7. Placez le répertoire 'C_lib_win' à la racine du répertoire 'game2'.
8. Ouvrez un 'EiffelStudio command prompt'.
<img width="1479" height="315" alt="image" src="https://github.com/user-attachments/assets/896f7f8c-9231-42f9-a322-8c7f4836d2db" />

9. Allez dans le répertoire 'game2/Clib' à l'aide de la commande 'cd contrib/library/game2/Clib'.
10. Une fois dans ce répertoire, exécutez la commande 'finish_freezing -library'.
11. Afin de vous assurez que tout fonctionne correctement, vous pouvez essayer de compiler un exemple de la libraire.

## Compiler un exemple
1. Choisissez un exemple dans 'game2/example'.
2. Copiez tous les DLLs le répertoire 'game2/C_lib_win/DLL32' ou 'game2/C_lib_win/DLL64'.
3. Collez tous les Dlls précédemment copiés dans le répertoire de l'exemple que vous voulez exécuter.
4. Double-cliquez sur le fichier avec l'extension 'ecf' du répertoire de votre exemple. Ce fichier a généralement le même nom que le répertoire.

# Description des issues - Pas d'issues dans mon dépôt git

## Ajouter Audio_video dans le project wizard
- J'ai dû apprendre à utiliser EiffelBuild, un outil permettant de générer des interfaces graphiques en Eiffel. Louis m'a brièvement expliqueé les différentes fonctionnalités qui me seraient utiles pour réaliser cette issue.
- Je me suis donc basé sur les cases à cocher qui existaient déjà pour faire la case à cocher pour Audio_video. Cependant, je n'ai jamais vu la constante des autres cases spécifiant leur état par défaut. Même lorsque je faisais une recherche sur la liste de constante de l'application, ces constantes n'apparaissaient pas. J'ai seulement eu connaissance de celles-ci en conversant avec Louis d'un problème que j'avais avec l'apparition de la case à cocher.
- Une grande difficulté aue j'ai rencontré est le manque de familiarité que j'avais avec la structure de la librairie Eiffel_Game2.
- Ensuite, j'ai dû rajouter du code qui gère l'ajout de la libraire Audio_video
- À chaque fois que je pensais que j'avais fini d'implémenter audio_video, il manquait quelque chose. Ensuite, j'ai vu que je l'avais implémenté à des endroits qu'il ne fallait pas. EN effet, ces endroits étaient des endroits où il était seulement nécessaire d'implémenter s'il y a  un controller. Cela créait donc une erreur de compilation externe C. 
- Problème avec la compilation externe en C. cause = code à des places où il ne fallait pas en mettre. Je me suis basé sur la librairie audio, mais il fallait que je me base sur la librairie audio_sound, puisque c'est la seul autre libraire qui n'a pas de controller et 'game_library_shared'. J'ai même cru qu'il fallait que je fasse un controller pour cette libraire, mais je n'avais aucune idée comment faire puisque tous les controllers sont très différents les uns des autres.

## Ajouter une gamepad_library à Eiffel_Game2
