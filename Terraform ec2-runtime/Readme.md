# 🚀 Terraform Runtime Platform

A cloud-based **Enterprise Runtime Platform** built using **Terraform**, **Docker**, and **AWS EC2**. This project provisions a complete development environment containing databases, web servers, AI tools, blockchain services, IoT platforms, metaverse components, and container management solutions using Infrastructure as Code (IaC).

---

## 📌 Project Overview

The objective of this project is to automate the deployment of a complete runtime platform for developers and enterprises using Terraform and Docker Compose.

The platform provisions an AWS EC2 instance, configures Docker automatically using cloud-init (userdata.sh), and deploys multiple containerized services with a single command.

---

# 🏗 Architecture

```
Developer
      │
      ▼
Terraform
      │
      ▼
AWS EC2 (Ubuntu)
      │
      ▼
Docker Engine
      │
      ▼
Docker Compose
      │
      ▼
Enterprise Runtime Platform
```

---

# ⚙ Technologies Used

- Terraform
- Docker
- Docker Compose
- AWS EC2
- Ubuntu Server
- Cloud-Init
- Git & GitHub

---

# ☁ Infrastructure

- AWS EC2
- Security Groups
- SSH Key Generation
- User Data Automation
- Docker Installation
- Automatic Container Deployment

---

# 🐳 Included Services

## Programming Runtime

- Python 3.12
- Node.js 22
- Java 21
- Go 1.22

---

## Databases

- MySQL
- MariaDB
- PostgreSQL
- MongoDB
- Redis

---

## Web Servers

- Nginx
- Apache HTTP Server
- Apache Tomcat
- WildFly (JBoss)

---

## Artificial Intelligence

- Jupyter Notebook

---

## Chatbot

- Open WebUI (LLM Interface)

---

## Internet of Things (IoT)

- EMQX MQTT Broker

---

## Blockchain

- Ganache
- Remix IDE

---

## Metaverse

- WebXR Demo (Nginx Hosted)

---

## Backend-as-a-Service (BaaS)

- PocketBase

---

## Container Management

- Portainer

---

# 📂 Project Structure

```
terraform-runtime-platform/

├── docker-compose.yml
├── userdata.sh
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── README.md
├── chatbot/
│   └── Dockerfile
├── webxr/
│   ├── Dockerfile
│   └── index.html
└── .gitignore
```

---

# 🚀 Deployment

## Clone Repository

```bash
git clone https://github.com/bilalasif8988-web/terraform-runtime-platform.git
```

```
cd terraform-runtime-platform
```

---

## Initialize Terraform

```bash
terraform init
```

---

## Validate

```bash
terraform validate
```

---

## Preview

```bash
terraform plan
```

---

## Deploy

```bash
terraform apply
```

---

# 🌐 Default Service Ports

| Service | Port |
|----------|------|
| Open WebUI | 3000 |
| Nginx | 8080 |
| Apache | 8081 |
| Tomcat | 8082 |
| WildFly | 8083 |
| Remix IDE | 8085 |
| Jupyter Notebook | 8888 |
| Portainer | 9000 |
| PocketBase | 8091 |
| WebXR | 8090 |
| MySQL | 3306 |
| MariaDB | 3307 |
| PostgreSQL | 5432 |
| MongoDB | 27017 |
| Redis | 6379 |
| EMQX MQTT | 1883 |
| EMQX Dashboard | 18083 |
| Ganache | 8545 |

---

# 📸 Demo

After deployment, services can be accessed using the EC2 Public IP.

Example:

```
http://<EC2-PUBLIC-IP>:3000
```

```
http://<EC2-PUBLIC-IP>:8080
```

```
http://<EC2-PUBLIC-IP>:9000
```

```
http://<EC2-PUBLIC-IP>:8090
```

etc.

---

# ✨ Features

- Infrastructure as Code (Terraform)
- Automated EC2 Provisioning
- Docker Runtime Installation
- Automatic Docker Compose Deployment
- Multiple Runtime Environments
- Multiple Databases
- AI Development Environment
- Blockchain Development Stack
- IoT Platform
- Metaverse Demo
- Container Management
- Backend-as-a-Service
- Modular and Easily Extendable

---

# 🔮 Future Enhancements

- Kubernetes Deployment
- Docker Swarm Support
- HashiCorp Vault
- MinIO Object Storage
- Grafana Monitoring
- Prometheus Metrics
- Jenkins CI/CD
- GitLab Runner
- Apache Kafka
- RabbitMQ
- ELK Stack
- OpenFaaS
- Knative
- GPU Runtime Support

---

# 👨‍💻 Author

**Bilal Asif**

DevOps | Cloud Computing | Terraform | Docker | AWS

GitHub:

https://github.com/bilalasif8988-web

---

# 📄 License

This project is developed for educational and internship purposes.
