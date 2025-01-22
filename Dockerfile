FROM python:3.9-slim

WORKDIR /app

# Install build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc python3-dev && \
    rm -rf /var/lib/apt/lists/*

# Copy and install requirements
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY src/ ./src/

# Expose Streamlit port
EXPOSE 8501

# Run Streamlit app
ENTRYPOINT ["streamlit", "run", "src/app.py", "--server.address=0.0.0.0", "--server.port=8501"]
