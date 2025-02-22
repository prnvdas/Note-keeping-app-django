# Use the official Python image from the Docker Hub
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Expose the port the app runs on
EXPOSE 8000

# Make migrations and migrate the database
RUN python manage.py makemigrations && python manage.py migrate

# Create a script to initialize the admin user
COPY create_superuser.py /app/create_superuser.py

# Command to run the server and initialize the admin user
CMD ["sh", "-c", "python manage.py runserver 0.0.0.0:8000 & python create_superuser.py"]