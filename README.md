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
git clone https://github.com/yourusername/rpi-docker-setup.git
cd rpi-docker-setup
git submodule init
git submodule update
```

### 2. Build the Docker image:

```bash
docker build -t rpi-env .
```

### 3. Run the Docker container:

```bash
docker run -d --name rpi-env-container -p 27017:27017 -p 5000:5000 rpi-env
```

### 4. Orchestrate with Docker Compose:

```bash
docker-compose up -d
```