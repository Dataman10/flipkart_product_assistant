# Parent image (Python 3.12 to match the version used locally with uv)
FROM python:3.12-slim

# Python behaviour inside the container
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Working directory inside the container
WORKDIR /app

# System dependencies (build tools are needed to compile some Python packages)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy project files (see .dockerignore for what is excluded)
COPY . .

# Install the project and its dependencies via setup.py
# --no-cache-dir keeps the image smaller by skipping pip's cache
RUN pip install --no-cache-dir -e .

# Flask port
EXPOSE 5000

# Start the app
CMD ["python", "app.py"]