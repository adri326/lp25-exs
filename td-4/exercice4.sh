#!/bin/sh

# This exercise can also be solved using the following command:
# [ -d "${1}" -a -d "${2}" ] && cp --update "${1}" "${2}"
# Although some of the behavior will vary from what was asked (for the better, in my humble opinion)

if [ -d "${1}" -a -d "${2}" ]; then
    for src in "${1}"/*; do
        dst="${2}/$(basename "${src}")"
        # If the source is a directory...
        if [ -d "${src}" ]; then
            # If the destination does not have that file...
            [ ! -e "${dst}" ] &&
                # Then copy it;
                echo "'${src}' -> '${dst}'" &&
                cp -r "${src}" "${dst}"
            # Continue the for loop
            continue
        fi
        # If the source is not a file, continue the for loop;
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
            echo "'${src}' -> '${dst}'"
            # Copy the file
            cp "${src}" "${dst}"
        fi
    done
fi
