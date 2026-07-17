# build da aplicação com Python 3.11 para melhor compatibilidade com as libs
FROM python:3.11-slim
WORKDIR /app

# copiar e instalar as dependências necessárias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copia os arquivos necessários para execução
COPY app.py modelo.py modelo_classificacao.joblib vectorizer_tfidf.joblib ./

# expõe a porta 8000
EXPOSE 8000

# termos usados para execução
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]