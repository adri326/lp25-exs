#!/bin/sh

# Affiche le type du fichier avec la commande `stat`;
echo "$1 is a $(stat -c "%F" "${1}")"
# Si le fichier est un fichier ordinaire...
[ -f "${1}" ] &&
    # Afficher ses permissions;
    echo "$1 has as permissions $(stat -c "%A" "${1}")"
