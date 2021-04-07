#!/bin/bash

# Executes getops and handle non-zero return codes
TEMP=$(getopt -l 'source:,destination:,dry-run,log-file::' -o '' -n 'exercice2.sh' -- "$@")
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
        # Argument --source found, a parameter is expected
        '--source')
            echo "Argument --source, avec paramètre '$2'"
            shift 2 # Remove the argument and parameter from the list
            continue
        ;;
        # Argument --destination found, a parameter is expected
        '--destination')
            echo "Argument --destination, avec paramètre '$2'"
            shift 2 # Remove the argument and parameter from the list
            continue
        ;;
        # Argument --dry-run found, no parameter expected
        '--dry-run')
            echo "Argument --dry-run"
            shift # Remove the argument from the list
            continue
        ;;
        # Argument --log-file found, check if a parameter was given
        '--log-file')
            case $2 in
                '')
                    echo "Argument --log-file, sans paramètre"
                ;;
                *)
                    echo "Argument --log-file, avec paramètre '$2'"
                ;;
            esac
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
