# Installation de la librarire Effeil_Game2 version développement

1. Créez un répertoire dans lequel cloner le projet.
2. Appelez-le 'game2'.
3. Faites 'git clone --recursive https://github.com/tioui/Eiffel_Game2.git game2' afin de clone le repo.
4. Faites un lien symbolique de votre répertoire 'game2' au répertoire 'contrib/library' d'EiffelStudio avec la commande suivante mklink "C:\Program Files\Eiffel Software\EiffelStudio 19.05 GPL\contrib\library\game2" "C:\<votre chemin vers 'game2'>game2".
5. Faites un 'git pull origin master' dans le répertoire 'game2' où vous avez cloné le projet afin d'être certain que vous êtes à jour. Il se peut que vous ayez à faire cette commande pour que cela fonctionne 'git config --global --add safe.directory 'C:/Program Files/Eiffel Software/EiffelStudio 19.05 GPL/contrib/library/game2''
6. Téléchargez ce fichier: https://github.com/tioui/Eiffel_Game2/raw/refs/heads/windows_build/C_libraries.zip.
7. Placez le répertoire 'C_lib_win' à la racine du répertoire 'game2'.
8. Ouvrez un 'EiffelStudio command prompt'.
9. Allez dans le répertoire 'game2/Clib' à l'aide de la commande 'cd'.
10. Une fois dans ce répertoire, exécutez la commande 'finish_freezing -library'.
11. Afin de vous assurez que tout fonctionne correctement, vous pouvez essayer de compiler un exemple de la libraire.

## Compiler un exemple
1. Choisissez un exemple dans 'game2/example'.
2. Copiez tous les DLLs dans le répertoire de l'exemple choisi. Vous pouvez trouver les DLLs dans le répertoire 'game2/C_lib_win/DLLXX'
3. Double-cliquez sur le fichier *.ecf du répertoire de votre exemple. Ce fichier a généralement le même nom que le répertoire.
