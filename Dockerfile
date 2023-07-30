# Base Image
FROM python:3.10-slim-bullseye
RUN pip install oloren
WORKDIR /app
COPY app.py .
# Default command for the container
CMD ["python", "app.py"]
