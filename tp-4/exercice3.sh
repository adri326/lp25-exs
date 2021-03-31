#!/bin/sh

function exists() {
  [ -e $1 ]
}

function usage() {
  echo "Usage: exercice3.sh <fichier>"
  echo "Returns true if that file exists, false otherwise"
}

if [ $# -ne 1 ]; then
  echo "Invalid command!"
  usage
else
  exists $1
fi
