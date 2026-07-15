#!/bin/bash

set -e

###########################################
# Update System
###########################################

apt-get update -y

###########################################
# Install Docker & Docker Compose
###########################################

apt-get install -y docker.io

# docker-compose-v2 is available on current Ubuntu images.  Fall back to the
# legacy package when the selected Ubuntu mirror does not provide it.
if ! apt-get install -y docker-compose-v2; then
apt-get install -y docker-compose
fi

systemctl enable docker
systemctl start docker

usermod -aG docker ubuntu

###########################################
# Create Docker Compose Directory
###########################################

mkdir -p /opt/runtime
mkdir -p /opt/runtime/webxr

###########################################
# Create docker-compose.yml
###########################################

cat <<EOF >/opt/runtime/docker-compose.yml

services:

  #################################
  # Runtime Containers
  #################################

  python:
    image: python:3.12
    container_name: python-runtime
    command: sleep infinity
    restart: unless-stopped

  node:
    image: node:22
    container_name: node-runtime
    command: sleep infinity
    restart: unless-stopped

  java:
    image: eclipse-temurin:21
    container_name: java-runtime
    command: sleep infinity
    restart: unless-stopped

  golang:
    image: golang:1.22
    container_name: go-runtime
    command: sleep infinity
    restart: unless-stopped

  #################################
  # MySQL
  #################################

  mysql:
    image: mysql:8.4
    container_name: mysql-db
    restart: unless-stopped

    environment:
      MYSQL_ROOT_PASSWORD: root123
      MYSQL_DATABASE: appdb
      MYSQL_USER: appuser
      MYSQL_PASSWORD: app123

    ports:
      - "3306:3306"

    volumes:
      - mysql_data:/var/lib/mysql

  #################################
  # MariaDB
  #################################

  mariadb:
    image: mariadb:11
    container_name: mariadb-db
    restart: unless-stopped

    environment:
      MARIADB_ROOT_PASSWORD: root123
      MARIADB_DATABASE: appdb
      MARIADB_USER: appuser
      MARIADB_PASSWORD: app123

    ports:
      - "3307:3306"

    volumes:
      - mariadb_data:/var/lib/mysql

  #################################
  # PostgreSQL
  #################################

  postgres:
    image: postgres:17
    container_name: postgres-db
    restart: unless-stopped

    environment:
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: admin123
      POSTGRES_DB: appdb

    ports:
      - "5432:5432"

    volumes:
      - postgres_data:/var/lib/postgresql/data

  #################################
  # MongoDB
  #################################

  mongodb:
    image: mongo:8
    container_name: mongodb
    restart: unless-stopped

    environment:
      MONGO_INITDB_ROOT_USERNAME: admin
      MONGO_INITDB_ROOT_PASSWORD: admin123

    ports:
      - "27017:27017"

    volumes:
      - mongodb_data:/data/db

  #################################
  # Redis
  #################################

  redis:
    image: redis:8
    container_name: redis
    restart: unless-stopped

    command: redis-server --appendonly yes

    ports:
      - "6379:6379"

    volumes:
      - redis_data:/data

  #################################
  # Nginx
  #################################

  nginx:
    image: nginx:latest
    container_name: nginx-server
    restart: unless-stopped

    ports:
      - "8080:80"

  #################################
  # Apache HTTP Server
  #################################

  httpd:
    image: httpd:2.4
    container_name: apache-server
    restart: unless-stopped

    ports:
      - "8081:80"

  #################################
  # Apache Tomcat
  #################################

  tomcat:
    image: tomcat:11-jdk21
    container_name: tomcat-server
    restart: unless-stopped

    ports:
      - "8082:8080"

  #################################
  # WildFly (JBoss)
  #################################

  wildfly:
    image: quay.io/wildfly/wildfly:latest
    container_name: wildfly-server
    restart: unless-stopped

    ports:
      - "8083:8080"



  #################################
  # Artificial Intelligence
  #################################

  jupyter:
    image: jupyter/base-notebook:latest
    container_name: ai-notebook
    restart: unless-stopped

    environment:
      JUPYTER_TOKEN: admin123

    ports:
      - "8888:8888"

  #################################
  # Chatbot (Open WebUI)
  #################################

  openwebui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: chatbot
    restart: unless-stopped

    ports:
      - "3000:8080"

    volumes:
      - openwebui_data:/app/backend/data

  #################################
# IoT Platform (EMQX)
#################################

  emqx:
    image: emqx/emqx:latest
    container_name: emqx
    restart: unless-stopped

    ports:
      - "1883:1883"
      - "18083:18083"
  #################################
  # Blockchain (Ganache)
  #################################

  blockchain:
    image: trufflesuite/ganache:latest
    container_name: blockchain
    restart: unless-stopped

    ports:
      - "8545:8545"

 #################################
 # Remix IDE
 #################################

  remix:
    image: remixproject/remix-ide:latest
    container_name: blockchain-remix
    restart: unless-stopped

    ports:
      - "8085:80"
  #################################
  # Container Management
  #################################

  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    restart: unless-stopped

    ports:
      - "9000:9000"

    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data

  pocketbase:
    image: spectado/pocketbase:latest
    container_name: pocketbase
    restart: unless-stopped

    ports:
      - "8091:8090"

    volumes:
      - pocketbase_data:/pb_data

  webxr:
    image: nginx:latest
    container_name: webxr
    restart: unless-stopped

    ports:
      - "8090:80"

    volumes:
      - /opt/runtime/webxr:/usr/share/nginx/html:ro

#################################
# Docker Volumes
#################################

volumes:

  mysql_data:
  mariadb_data:
  postgres_data:
  mongodb_data:
  redis_data:
  portainer_data:
  openwebui_data:
  pocketbase_data:

EOF

cat <<'EOF' >/opt/runtime/webxr/index.html
${webxr_index}
EOF

###########################################
# Start Containers
###########################################

cd /opt/runtime

if docker compose version >/dev/null 2>&1; then
docker compose up -d
else
docker-compose up -d
fi

echo "========================================="
echo "Runtime Containers Ready"
echo "Database Containers Ready"
echo "Web Server Containers Ready"
echo "Artificial Intelligence Ready"
echo "Chatbot Ready"
echo "IoT Platform Ready"
echo "Blockchain Ready"
echo "Container Management Ready"
echo "========================================="
