FROM python:3.11-slim-bookworm

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg libsm6 libxext6 fontforge potrace git && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch main https://github.com/sakshamarora1/handwrite && \
    cd handwrite && pip install --no-cache-dir -e .

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PORT=5000

CMD ["gunicorn", "app:create_app()", "--log-level", "debug", "--timeout", "90", "--workers", "2", "--max-requests", "20", "--config", "config.py"]
