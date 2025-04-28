#!/bin/bash

# Atualiza o sistema
sudo apt-get update
sudo apt-get upgrade -y

# Instala o Apache
sudo apt-get install -y apache2

# Habilita o mod_rewrite para Apache
sudo a2enmod rewrite

# Configura o Apache para utilizar a pasta sincronizada
sudo tee /etc/apache2/sites-available/000-default.conf << EOF
<VirtualHost *:80>
    DocumentRoot /var/www/html
    <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

# Reinicia o Apache para aplicar as mudanças
sudo systemctl restart apache2

# Instala dependências adicionais conforme necessário
# Por exemplo, instalar o PHP
# sudo apt-get install -y php libapache2-mod-php

# Limpeza de pacotes não mais necessários
sudo apt-get autoremove -y
