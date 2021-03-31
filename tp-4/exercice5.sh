#!/bin/env bash

declare -A hashes
declare -A names

# NOTE: avoir une unique hashmap (hash -> filename) multiplie grandement la vitesse du programme

# Pour tous les fichierse dans Photos...
for file in Photos/*/*; do
  # Calculer le hash du fichier;
  sum=$(md5sum $file | cut -d' ' -f1) &&

  # Si un fichier homonyme a déjà été trouvé...
  [[ -v names[$(basename "${file}")] ]] &&
    # si les fichiers ont le même hash...
    [[ ${hashes[$(basename "${file}")]} = ${sum} ]] &&
    # afficher un message...
    echo "'${names[$(basename ${file})]}' -> '${file}'" &&
    # supprimer le fichier...
    rm "$file" &&
    # et créer un hardlink;
    ln "${names[$(basename ${file})]}" "$file" ||
    # Sinon, ajouter les fichiers aux deux tables;
    hashes[$(basename "${file}")]="${sum}" &&
    names[$(basename "${file}")]="${file}"
done
