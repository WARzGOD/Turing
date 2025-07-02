FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# A camada de instalação de dependências só será reconstruída se o requirements.txt mudar.
COPY requirements.txt .

# Instala as dependências
# --no-cache-dir: Desabilita o cache do pip, o que ajuda a manter o tamanho da imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que a aplicação será executada
EXPOSE 8000

# Comando para executar a aplicação quando o container iniciar.
# --host 0.0.0.0 é essencial para que a aplicação seja acessível de fora do container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

