#!/bin/env bash

## Écrire un script qui parcourt un dossier récursivement, et stocke dans un fichier une liste de tous les fichiers et dossiers trouvés, et pour les fichiers, la date de dernière modification et l'empreinte MD5 (md5sum).
## Le script écrit les dossiers dans le fichier de sortie en les terminant par un /, et les fichiers sans /.
## Les informations des fichiers sont sur la même ligne que le nom, et séparées par des tabulations.
##
## Le script est appelé avec deux arguments dans l'ordre suivant : DOSSIER FICHIER_DE_SORTIE.
## Le script vérifie l'existence des paramètres ainsi que leur validité (le premier argument doit exister et être un dossier, le second doit exister et être un fichier, et il doit être hors du dossier).

# Affiche un message expliquant comment utiliser le script
function utilisation() {
    echo "Utilisation: exam.sh <DOSSIER> <FICHIER_DE_SORTIE>"
    echo "Note: FICHIER_DE_SORTIE doit déjà exister et ne doit pas être dans DOSSIER"
}

# Si le script n'a pas été appelé avec deux arguments...
if [ $# != 2 ]; then
    # Afficher une erreur et sortir.
    echo "ERREUR: Nombre invalide d'arguments!"
    utilisation && exit 1
fi

# Si l'argument DOSSIER n'est pas un dossier...
if [ ! -d "$1" ]; then
    # Afficher une erreur et sortir.
    echo "ERREUR: $1 n'est pas un dossier!"
    utilisation && exit 2
fi

# Si l'argument FICHIER_DE_SORTIE n'est pas un fichier...
if [ ! -f "$2" ]; then
    # Afficher une erreur et sortir.
    echo "ERREUR: $2 n'est pas un fichier!"
    utilisation && exit 3
fi

# Si l'argument FICHIER_DE_SORTIE se trouve dans DOSSIER (ou dans un dossier enfant de DOSSIER)...
if [[ "$(dirname "$2")" == "$1"* ]]; then
    # Afficher une erreur et sortir.
    echo "ERREUR: $2 est dans $1!"
    utilisation && exit 4
fi

export FICHIER_DE_SORTIE="$2"

# Pour tous les fichiers et dossiers dans DOSSIER...
find "$1" -type d,f -exec "bash" "-c" $'
    # Si le fichier est un fichier normal...
    if [ -f "$1" ]; then
        # Echo le nom du fichier, la somme md5 et la dernière date de modification dans FICHIER_DE_SORTIE.
        echo "$1\t$(stat -c "%y" "$1")\t$(md5sum "$1" | cut -d" " -f1)" >> "$FICHIER_DE_SORTIE"
    else # Si le fichier est un dossier...
        # Le rajouter dans FICHIER_DE_SORTIE avec un `/`.
        echo "$1/" >> "$FICHIER_DE_SORTIE"
    fi
' "--" "{}" ";"
