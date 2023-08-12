# Stage 1: Build the Python application
FROM python:3.9 as builder

# Set working directory
WORKDIR /app

# Copy the application code to the container
COPY app /app

# Install the required Python packages
COPY requirements.txt /app  

RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Create a lightweight production image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy only necessary files from the builder stage
COPY --from=builder /app /app

# Install the required Python packages in the final image
RUN pip install --no-cache-dir -r requirements.txt

# Expose any required ports (if your application listens on a specific port)
EXPOSE 8000

# Define the command to run your application
CMD ["python", "app.py"]
