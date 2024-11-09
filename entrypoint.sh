#!/bin/bash

# Start MongoDB service
echo "Starting MongoDB..."
service mongodb start

# Start the Grafana service
/usr/sbin/grafana-server --homepath=/usr/share/grafana &

# Start Flask application from the FFRHAS submodule
echo "Starting FFRHAS Flask application..."
cd /opt/FFRHAS/HAS && python3 app.py &

# Keep the container running
tail -f /dev/null
