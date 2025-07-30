# Raspberry Pi Dockerized Environment for FFRHAS

A complete, reproducible, and extensible Docker-based setup for running the FFRHAS application stack on Raspberry Pi. This repository provides everything you need: application, database, monitoring, and system scripts.

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Service Details](#service-details)
- [Configuration](#configuration)
- [Development & Maintenance](#development--maintenance)
- [Useful Docker Commands](#useful-docker-commands)
- [Scripts](#scripts)
- [References](#references)

---

## Overview

This project enables you to deploy the FFRHAS Python/Flask application, MongoDB, and Grafana (with MongoDB datasource) on a Raspberry Pi using Docker Compose. It includes scripts for system setup and network configuration, and supports persistent storage and environment-based configuration.

---

## Architecture

```
+-------------------+      +-------------------+      +-------------------+
|    Flask App      |<---->|     MongoDB       |<---->|     Grafana       |
|  (FFRHAS)         |      |   (arm64v8)       |      | (with MongoDB     |
|                   |      |                   |      |  datasource)      |
+-------------------+      +-------------------+      +-------------------+
        |                        |                           |
        +------------------------+---------------------------+
                             Docker Compose
```

- **Flask App**: Python 3.9, runs FFRHAS from `/opt/FFRHAS/HAS`
- **MongoDB**: ARM64 image, persistent storage
- **Grafana**: Pre-configured with MongoDB datasource plugin

---

## Features

- **Multi-container orchestration** with Docker Compose
- **ARM64 support** for Raspberry Pi 4/5 and similar devices
- **Persistent volumes** for MongoDB and Grafana data
- **Environment variable configuration** via `.env`
- **Static IP setup** for Ethernet via included scripts
- **Pre-installed utilities** for Raspberry Pi setup
- **Grafana** with MongoDB datasource for monitoring and dashboards

---

## Prerequisites

- Raspberry Pi (recommended: Pi 4 or newer, 64-bit OS)
- Docker & Docker Compose installed
- Git installed

---

## Quick Start

1. **Clone the repository and initialize submodules:**
    ```bash
    git clone https://github.com/mendax0110/rpi-docker-setup.git
    cd rpi-docker-setup
    git submodule update --init --recursive
    sudo chmod -R 777 grafana
    ```

2. **Configure environment variables:**
    - Copy `.env.example` to `.env` and edit as needed (MongoDB, Grafana credentials, etc.)

3. **Build and start the stack:**
    ```bash
    docker-compose build --no-cache
    docker-compose up -d
    ```

4. **Access services:**
    - **Flask App**: [http://localhost:5000](http://localhost:5000)
    - **MongoDB**: `localhost:27017`
    - **Grafana**: [http://localhost:3000](http://localhost:3000)

---

## Service Details

| Service    | Port   | Description                                   | Data Volume                      |
|------------|--------|-----------------------------------------------|----------------------------------|
| Flask App  | 5000   | Main Python/Flask application (FFRHAS)        | -                                |
| MongoDB    | 27017  | Database, ARM64 image                         | `./mongo/data:/data/db`          |
| Grafana    | 3000   | Dashboards, MongoDB datasource pre-installed  | `./grafana/grafana_storage`      |

---

## Configuration

- **Environment Variables**:  
  Set in `.env` (see `.env.example` for all options).
- **Volumes**:  
  Data is persisted in `mongo/data` and `grafana/grafana_storage`.
- **Network**:  
  All services are on the `app_network` Docker bridge.

---

## Development & Maintenance

- **Submodules**:  
  FFRHAS is included as a git submodule. Update with:
  ```bash
  git submodule update --remote
  ```
- **Scripts**:  
  - `init-scripts/setup-network.sh`: Configure static IP for Ethernet
  - `utils/setup_pi.sh`: Install essential packages on a new Pi

---

## Useful Docker Commands

| Action                       | Command                                 |
|------------------------------|-----------------------------------------|
| Build all services           | `docker-compose build`                  |
| Build without cache          | `docker-compose build --no-cache`       |
| Start services (foreground)  | `docker-compose up`                     |
| Start services (background)  | `docker-compose up -d`                  |
| Stop services                | `docker-compose stop`                   |
| Restart services             | `docker-compose restart`                |
| View logs                    | `docker-compose logs`                   |
| View logs (follow)           | `docker-compose logs -f`                |
| Logs for a service           | `docker-compose logs <service>`         |
| Status                       | `docker-compose ps`                     |
| Remove all containers        | `docker-compose down`                   |

---

## Scripts

- **Network Setup**:  
  [`init-scripts/setup-network.sh`](init-scripts/setup-network.sh)  
  Sets a static IP for `eth0` via `/etc/network/interfaces`.

- **Raspberry Pi Essentials**:  
  [`utils/setup_pi.sh`](utils/setup_pi.sh)  
  Installs common tools and Python dependencies.

---

## References

- [FFRHAS App](https://github.com/mendax0110/FFRHAS)
- [MongoDB ARM64 Docker Image](https://hub.docker.com/r/arm64v8/mongo)
- [Grafana OSS](https://grafana.com/grafana/download)
- [MongoDB Grafana Datasource](https://github.com/haohanyang/mongodb-datasource)

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.