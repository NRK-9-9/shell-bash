#!/bin/bash
# Verifie si le script est execute en tant que root
if [ "$EUID" -ne 0 ]; then
  echo "Veuillez executer ce script en tant que root ou avec sudo."
  exit 1
fi

# Mise a jour du systeme
echo "Mise a jour du systeme..."
apt update && apt upgrade -y

# Installation de Nginx
echo "Installation de Nginx..."
apt install nginx -y

# Activation et demarrage de Nginx
echo "Activation et demarrage de Nginx..."
systemctl enable nginx
systemctl start nginx

# Verifier si Nginx fonctionne
if systemctl is-active --quiet nginx; then
  echo "Nginx a ete installe et fonctionne correctement."
else
  echo "Erreur : Nginx n'a pas pu etre lance."
  exit 1
fi

# Installation de Bind9
echo "Installation de Bind9..."
apt install bind9 bind9utils bind9-doc -y

# Activation et demarrage de Bind9
echo "Activation et demarrage de Bind9..."
systemctl enable bind9
systemctl start bind9

# Verifier si Bind9 fonctionne
if systemctl is-active --quiet bind9; then
  echo "Bind9 a ete installe et fonctionne correctement."
else
  echo "Erreur : Bind9 n'a pas pu etre lance."
  exit 1
fi

# Afficher les versions installees
echo "Versions des services installees :"
nginx -v
named -v

echo "Installation de Nginx et Bind9 terminee avec succes !"
