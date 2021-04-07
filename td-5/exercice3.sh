#!/bin/sh

# Executes getops and handle non-zero return codes
TEMP=$(getopt -l 'help,verbose,source:,destination:,dry-run,log-file::' -o 'hv' -n 'exercice3.sh' -- "$@")
if [ $? -ne 0 ]; then
    echo "Erreur!"
    exit 1
fi

# Inject the result of getops into the argument list
eval set -- "$TEMP"
unset TEMP

# Default values
VERBOSE=false
DRY_RUN=false

# Loop over the arguments...
while true; do
    # Look at the head argument...
    case "$1" in
        # Argument -h or --help found, no parameter is expected
        'h'|'--help')
            echo "exercice3.sh: copies files from a directory to another, unless they are already present or newer"
            echo "Usage: exercice3.sh [-h|--help] [-v|--verbose] --source <SRC_PATH> --destination <DST_PATH> [--dry-run] [--log-file[=<LOG_PATH>]]"
            echo "If --dry-run is set, no file will be copied/overwritten"
            echo "If --log-file is set, a log called journal.log or LOG_PATH will be created"
            exit 0 # Stop the program
        ;;
        # Argument -v or --verbose found, no parameter is expected
        'v'|'--verbose')
            VERBOSE=true
            shift # Remove the argument from the list
            continue
        ;;
        # Argument --source found, a parameter is expected
        '--source')
            SRC=$2
            shift 2 # Remove the argument and parameter from the list
            continue
        ;;
        # Argument --destination found, a parameter is expected
        '--destination')
            DST=$2
            shift 2 # Remove the argument and parameter from the list
            continue
        ;;
        # Argument --dry-run found, no parameter expected
        '--dry-run')
            echo "Dry run! No file will be modified!"
            DRY_RUN=true
            shift # Remove the argument from the list
            continue
        ;;
        # Argument --log-file found, check if a parameter was given
        '--log-file')
            case $2 in
                '')
                    LOG=journal.log
                ;;
                *)
                    LOG=$2
                ;;
            esac
            shift 2 # Remove the argument and parameter from the list
            continue
        ;;
        # End of arguments, ignore the remaining ones
        '--')
            shift
            break
        ;;
        # Unexpected token
        *)
            echo "Erreur!"
            exit 1
        ;;
    esac
done

# If both SRC and DST are valid...
if [ -n "${SRC}" -a -n "${DST}" -a -d "${SRC}" -a -d "${DST}" ]; then
    # For all `src` in $SRC/*
    for src in "$SRC"/*; do
        dst="$DST/$(basename "${src}")"
        # If the source is a directory...
        if [ -d "${src}" ]; then
            # If the destination does not have that file...
            if [ ! -e "${dst}" ]; then
                # Then copy it;
                # Print info if $VERBOSE is true;
                $VERBOSE && echo "'${src}' -> '${dst}'"
                # Log to $LOG if $LOG is set;
                [ -n "$LOG" ] && (echo "'${src}' -> '${dst}'" >> "$LOG")
                # Copy the file if DRY_RUN is false;
                $DRY_RUN || cp -r "${src}" "${dst}"
            fi
            # Continue the for loop
            continue
        fi
        # If the source is not a regular file, continue the for loop;
        [ ! -f "${src}" ] && continue
        # Compute both hashes
        hashsrc=$(md5sum "${src}" | cut -d' ' -f1)
        hashdst=$(if [ -e "${dst}" ]; then md5sum "${dst}" | cut -d' ' -f1; fi)

        # If the destination file does not exist, or...
        if [ ! -e "${dst}" ] || (
            # If it is a file
            [ -f "${dst}" ] &&
            # And if it is older than the source...
            [ "${src}" -nt "${dst}" ] &&
            # And if the hashes differ...
            [ "${hashsrc}" != "${hashdst}" ]
        ); then
            # Print info if $VERBOSE is true;
            $VERBOSE && echo "'${src}' -> '${dst}'"
            # Log to $LOG if $LOG is set;
            [ -n "$LOG" ] && (echo "'${src}' -> '${dst}'" >> "$LOG")

            # If the file already exists...
            if [ -f "${dst}" ]; then
                # Print info if $VERBOSE is true;
                $VERBOSE && echo "'${dst}' -> '${dst}-$(stat -c "%Y" "${dst}")'"
                # Log to $LOG if $LOG is set;
                [ -n "$LOG" ] && (echo "'${dst}' -> '${dst}-$(stat -c "%Y" "${dst}")'" >> "$LOG")
                # Back it up first if DRY_RUN is false;
                $DRY_RUN || mv "${dst}" "${dst}-$(stat -c "%Y" "${dst}")"
            fi
            # Copy the file if DRY_RUN is false;
            $DRY_RUN || cp "${src}" "${dst}"
        fi
    done
fi
