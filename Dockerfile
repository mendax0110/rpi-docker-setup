# Use a Raspberry Pi-compatible Ubuntu base image (64-bit architecture)
FROM arm64v8/ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Update system and install essential packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    net-tools \
    iputils-ping \
    dnsutils \
    curl \
    wget \
    nano \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    gnupg \
    git \
    gnupg2 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Flask and cors
RUN pip3 install Flask
RUN pip install Flask-Cors

# Add MongoDB repository for ARM64 (MongoDB 4.4)
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | gpg --dearmor -o /usr/share/keyrings/mongodb.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/mongodb.gpg arch=arm64] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.4.list

# Install MongoDB
RUN apt-get update && apt-get install -y --no-install-recommends \
    mongodb-org

# Set up MongoDB directories and permissions
RUN mkdir -p /data/db && chown -R mongodb:mongodb /data/db

# Copy the FFRHAS submodule to the image
COPY FFRHAS /opt/FFRHAS

# Expose MongoDB and Flask app ports
EXPOSE 27017
EXPOSE 5000

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Start the services
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Keep the container running
CMD ["tail", "-f", "/dev/null"]
