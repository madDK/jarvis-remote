FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt-get/lists/*

# Copy requirements & install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Expose Hugging Face default port
EXPOSE 7860

# Start Uvicorn Server
CMD ["uvicorn", "dashboard.server:app", "--host", "0.0.0.0", "--port", "7860"]
