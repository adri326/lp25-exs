#!/bin/sh

# Si la commande appelée est `TriUsers.sh`...
[ $(basename $0) = "TriUsers.sh" ] &&
    # Afficher /etc/passwd dans l'ordre alphabétique;
    sort /etc/passwd | more
# Si la commande appelée est `InvTriUsers.sh`...
[ $(basename $0) = "InvTriUsers.sh" ] &&
    # Afficher /etc/passwd dans l'ordre inverse;
    sort -r /etc/passwd | more
