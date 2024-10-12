# Use a Raspberry Pi-compatible Debian base image
FROM arm32v7/debian:bullseye-slim

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
    mongodb-server \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up network configurations (optional)
COPY init-scripts/setup-network.sh /usr/local/bin/setup-network.sh
RUN chmod +x /usr/local/bin/setup-network.sh && /usr/local/bin/setup-network.sh

# Create user 'pi' and set password
RUN useradd -ms /bin/bash pi && echo "pi:raspberry" | chpasswd && usermod -aG sudo pi

# Set up MongoDB directories
RUN mkdir -p /data/db && chown -R mongodb:mongodb /data/db

# Copy application from the FFRHAS submodule
COPY FFRHAS /opt/FFRHAS

# Install Python dependencies from the FFRHAS repository
RUN pip3 install --upgrade pip && pip3 install -r /opt/FFRHAS/requirements.txt

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
