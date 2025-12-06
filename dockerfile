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
COPY dummy_db.sqlite ./dummy_db.sqlite
# Variable de entorno por defecto (la eliminamos o la dejamos, no es crítica)
ENV PORT=5000
# Exponer puerto
EXPOSE ${PORT}
# Ejecutar toolbox con el formato exec
CMD ["./toolbox", "--tools-file", "tools.yaml", "--port", "${PORT}", "--host", "0.0.0.0"]
