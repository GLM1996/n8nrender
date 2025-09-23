FROM n8nio/n8n:latest

# Exponer puerto de n8n
EXPOSE 5678

# Instalar curl para health checks
USER root
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
USER node

# Health check para Render
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:5678/healthz || exit 1

# Variables por defecto (pueden ser sobreescritas por env vars)
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
