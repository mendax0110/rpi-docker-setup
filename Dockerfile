# Use the official Python image as a base
FROM python:3.9-slim

ENV connectionstring = "mongodb://admin:secret@mongodb:27017"

# Set the working directory
WORKDIR /app

# Copy the application code into the container
COPY /FFRHAS/HAS /opt/FFRHAS/HAS

# Install Python dependencies
RUN pip install --no-cache-dir -r /opt/FFRHAS/HAS/requirements.txt

# Expose the port the app runs on
EXPOSE 5000

# Command to run the application
CMD ["python3", "/opt/FFRHAS/HAS/app.py"]
