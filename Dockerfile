# Build image from a base Python image
FROM python:3.9-slim

# Copy necessary files into the image
COPY . /app

# Set the working directory inside the image
WORKDIR /app

# Install dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Define the command to run when the container starts
CMD ["python", "app.py"]
