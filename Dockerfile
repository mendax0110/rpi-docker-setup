# Use a Raspberry Pi-compatible Ubuntu base image (64-bit architecture)
FROM arm64v8/ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Update system and install essential packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Flask and Flask-Cors
RUN pip3 install Flask Flask-Cors

# Copy the FFRHAS submodule to the image
COPY FFRHAS /opt/FFRHAS

# Set working directory
WORKDIR /opt/FFRHAS/HAS

# Expose Flask app port
EXPOSE 5000

# Run the Flask application
CMD ["python3", "app.py"]
