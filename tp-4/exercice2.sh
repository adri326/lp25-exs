#!/bin/env bash

echo "Cette commande a $# arguments!"
echo "Les voicis dans l'ordre croissant:"

for i in $(seq 1 $#); do
  echo "Argument $i: '${@:$i:1}'"
done

echo "Les voicis dans l'ordre décroissant:"

for i in $(seq $# -1 1); do
  echo "Argument $i: '${@:$i:1}'"
done
