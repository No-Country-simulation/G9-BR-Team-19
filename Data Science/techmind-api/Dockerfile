# TechMind API — imagem de produção
FROM python:3.11-slim

WORKDIR /app

# Instala dependências primeiro (aproveita cache do Docker entre builds)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o código da API e os artefatos treinados
COPY app/ ./app/
COPY artifacts/ ./artifacts/

ENV ARTIFACTS_DIR=/app/artifacts
ENV PORT=8000

EXPOSE 8000

# Healthcheck útil para orquestradores de container
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s \
    CMD python -c "import os, urllib.request; urllib.request.urlopen(f'http://localhost:{os.environ.get(\"PORT\", 8000)}/health')" || exit 1

# Usa $PORT (Render e outras plataformas injetam essa variável dinamicamente)
CMD ["sh", "-c", "uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000}"]
