#!/bin/sh

# Lire 128 charactères de /dev/urandom
head -c128 < /dev/urandom |
  # Calculer le hash de ces charactères
  md5sum |
  # Prendre les 16 premiers charactères du hash
  head -c16
