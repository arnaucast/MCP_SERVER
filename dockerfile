FROM debian:bullseye-slim

WORKDIR /app

# Instalar curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Descargar e instalar toolbox
ENV VERSION=0.22.0
RUN curl -L -o toolbox https://storage.googleapis.com/genai-toolbox/v${VERSION}/linux/amd64/toolbox && \
    chmod +x toolbox

# Copiar archivos de configuración
COPY tools.yaml ./tools.yaml
COPY dummy_Db.sqlite ./dummy_Db.sqlite

# Exponer puerto
EXPOSE 5000

# Ejecutar toolbox
CMD ["./toolbox", "--tools-file", "tools.yaml", "--port", "5000", "--host", "0.0.0.0"]
