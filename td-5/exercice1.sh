#!/bin/bash

# Executes getops and handle non-zero return codes
TEMP=$(getopt -o 'hs:o::' -n 'exercice1.sh' -- "$@")
if [ $? -ne 0 ]; then
    echo "Erreur!"
    exit 1
fi

# Inject the result of getops into the argument list
eval set -- "$TEMP"
unset TEMP

# Loop over the arguments...
while true; do
    # Look at the head argument...
    case "$1" in
        # Argument -h found, no parameter expected
        '-h')
            echo "Argument -h"
            shift # Remove the argument from the list
            continue
        ;;
        # Argument -o found, check if a parameter was given
        '-o')
            case $2 in
                '')
                    echo "Argument -o, sans paramètre"
                ;;
                *)
                    echo "Argument -o, avec paramètre '$2'"
                ;;
            esac
            shift 2 # Remove the argument and parameter from the list
            continue
        ;;
        # Argument -s found, a parameter is expected
        '-s')
            echo "Argument -s, avec paramètre '$2'"
            shift 2 # Remove the argument and parameter from the list
            continue
        ;;
        # End of arguments, print the remaining ones
        '--')
            shift
            echo "Arguments restants: '$@'"
            break
        ;;
        # Unexpected token
        *)
            echo "Erreur!"
            exit 1
        ;;
    esac
done
