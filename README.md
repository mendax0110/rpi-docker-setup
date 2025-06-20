# Raspberry Pi Docker Setup with FFRHAS

This repository contains Docker configurations and scripts to set up a Raspberry Pi-compatible environment, integrating the FFRHAS app as a submodule.

## Features
- **Python 3** with Flask application (FFRHAS submodule)
- **MongoDB** database setup
- Static IP configuration for **Ethernet**
- **User `pi`** with sudo access
- Support for **environment variables** via `.env`

## Prerequisites
- Raspberry Pi with Docker installed
- Git installed on your Raspberry Pi

## Getting Started

### 1. Clone the repository and initialize the submodule:

```bash
git clone https://github.com/mendax0110/rpi-docker-setup.git
cd rpi-docker-setup
git submodule init
git submodule update --init --recursive
sudo chmod -R 777 grafana
```

### 2. Allow all on grafana directory:

```bash
chmod 777 grafana
```

### 3.  Build the Docker image:

```bash
docker-compose build --no-cache
```

### 4. Orchestrate with Docker Compose:

```bash
docker-compose up -d
```

### 5. General important Docker commands:

- 1. Check the logs
```bash
docker-compose logs
```

- 2. Check the logs realtime
```bash
docker-compose logs -f
```

- 3. Check the logs of specific service
```bash
docker-compose logs <service-name>
```

- 4. Restart Services
```bash
docker-compose restart
```

- 5. Restart specific service
```bash
docker-compose restart <service-name>
```

- 6. Start Services
```bash
docker-compose up
```

- 7. Start Services in background
```bash
docker-compose up -d
```

- 8. Start specific service
```bash
docker-compose up <service-name>
```

- 9. Stop Services
```bash
docker-compose stop
```

- 10. Stop specific service
```bash
docker-compose stop <service-name>
```

- 11. Rebuild Services
```bash
docker-compose build
```

- 12. Rebuild without cache
```bash
docker-compose build --no-cache
```

- 13. Check Status
```bash
docker-compose ps
```

- 14. Shut down and remove all containers
```bash
docker-compose down
```
