# Base Image
FROM python:3.10-slim-bullseye

# Installing necessary packages
RUN apt-get update && apt-get install -y gcc g++
RUN pip install jupyter

ENV EXTENSION_NAME=...
ENV JUPYTER_PORT=...

RUN pip install oloren

# Copying application code to the Docker image
WORKDIR /app
COPY app.py .
# Default command for the container
CMD ["python", "app.py"]
