# Stage 1: Build the Python application
FROM python:3.9 as builder

# Set working directory
WORKDIR /app

# Copy the application code to the container
COPY app /app

# Install build dependencies (if needed)
# For example, if your application has specific build requirements or dependencies, install them here.

# Install the required Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Create a lightweight production image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy only necessary files from the builder stage
COPY --from=builder /app /app

# Expose any required ports (if your application listens on a specific port)
EXPOSE 8000

# Define the command to run your application
CMD ["python", "app.py"]

