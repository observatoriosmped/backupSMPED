# Documento de (re)implantação do portal 1.0
# https://docs.google.com/document/d/14X0_xlW6fLp7T3mJyttl8fRJShR-8LVD_6qj2BRpJP0/edit

#!/bin/bash

# Script para renovacao automatica dos certificados digitais do ObservatorioSMPED

# Parar o container do proxy
docker stop proxy_nginx_1

# Iniciar nginx para renovação dos certificados
systemctl start nginx

# Atualizar todos os certificados digitais
sudo certbot --nginx -d observatorio.smped.prefeitura.sp.gov.br -d adm.observatorio.smped.prefeitura.sp.gov.br -d api.observatorio.smped.prefeitura.sp.gov.br -d configurador.observatorio.smped.prefeitura.sp.gov.br -d graficos.observatorio.smped.prefeitura.sp.gov.br -d paineis.observatorio.smped.prefeitura.sp.gov.br

#Attempt to reinstall this existing certificate
1


# Parar nginx para desocupar a porta de rede http para o container do proxy

sudo systemctl stop nginx
sudo systemctl disable nginx

# Copiar os arquivos atualizados para o projeto
/bin/cp --force  /etc/letsencrypt/live/observatorio.smped.prefeitura.sp.gov.br-0001/fullchain.pem /root/implantacao_2020_08_18/ObservatorioSMPED/proxy/data/certbot/conf/live/all/

/bin/cp --force   /etc/letsencrypt/live/observatorio.smped.prefeitura.sp.gov.br-0001/privkey.pem /root/implantacao_2020_08_18/ObservatorioSMPED/proxy/data/certbot/conf/live/all/

# Iniciar o container do proxy

cd implantacao_2020_08_18
cd ObservatorioSMPED
cd proxy
docker-compose up -d --build
cd ..
