FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    portaudio19-dev \
    ffmpeg \
    && rm -rf /var/lib/apt-get/lists/*

# Copy requirements & install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Environment flag for 24/7 Headless Cloud execution
ENV HEADLESS=1
EXPOSE 7860

# Run Full Autonomous Cloud JARVIS Engine + Dashboard
CMD ["python", "main.py"]
