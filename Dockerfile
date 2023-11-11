# Use the official Python image as the base image
FROM python:3.12

# Set the working directory within the container
WORKDIR /app

# Copy the requirements file and install dependencies
RUN pip install --upgrade pip
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

# Copy the rest of the application code to the container
COPY app app

# Expose the port that the Flask app will run on
EXPOSE 5000

# Set environment variables (optional)
ENV FLASK_APP=app/app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Command to run the Flask application
CMD ["flask", "run"]


