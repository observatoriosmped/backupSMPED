# Documento de (re)implantação do portal 1.0
# https://docs.google.com/document/d/14X0_xlW6fLp7T3mJyttl8fRJShR-8LVD_6qj2BRpJP0/edit

#!/bin/bash

# Script para renovacao automatica dos certificados digitais do ObservatorioSMPED
cd
cd backupSMPED

#Attempt to reinstall this existing certificate
echo "1" | ./renew_certificates_2022.sh

cd 

# Script para reiniciar todos os containers

docker restart mongodb-observatorio
docker restart controle-acesso-backend
docker restart configurador-backend
docker restart grafico-backend
docker restart paineis-backend
docker restart portal-backend
docker restart gateway

docker restart portal-frontend
docker restart configurador-frontend
docker restart grafico-frontend
docker restart paineis-frontend
docker restart landing-page
docker restart proxy_nginx_1
