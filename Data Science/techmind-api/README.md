# TechMind API

API REST de classificação temática de conteúdos técnicos, construída com **FastAPI**.

Consome os artefatos gerados pelo notebook de Data Science
(`modelo_classificacao.joblib` e `vectorizer_tfidf.joblib`) e expõe o
endpoint `POST /conteudo`, que recebe um título e um texto e retorna a
categoria prevista, a probabilidade de confiança, as tags (palavras-chave)
e um resumo extrativo.

## 🌐 API no ar

- **URL pública**: https://techmind-api.onrender.com
- **Documentação interativa**: https://techmind-api.onrender.com/docs

⚠️ Roda no plano gratuito do Render, então pode demorar ~30-60s para
responder na primeira chamada após um tempo sem uso (ela "dorme" por
inatividade).

## Localização no repositório

Este projeto vive em `Data Science/techmind-api/` dentro do repositório
`G9-BR-Team-19` (a pasta `backend/` pertence a outra equipe e não deve
ser alterada por este projeto).

## Estrutura de pastas

```
techmind-api/
├── app/
│   ├── __init__.py
│   ├── main.py              # Aplicação FastAPI (rotas)
│   ├── inference.py         # Carregamento dos artefatos e predição
│   ├── text_processing.py   # Limpeza de texto (mesma lógica do notebook)
│   └── schemas.py           # Schemas Pydantic de request/response
├── artifacts/
│   ├── modelo_classificacao.joblib
│   └── vectorizer_tfidf.joblib
├── tests/
│   └── test_api.py
├── Dockerfile
├── .dockerignore
├── render.yaml
├── requirements.txt
└── README.md
```

## ⚠️ Antes de rodar: artefatos do modelo

Se os arquivos `modelo_classificacao.joblib` e `vectorizer_tfidf.joblib`
dentro de `artifacts/` não forem os mais recentes, copie-os da pasta
`Data Science/` (gerados pelo notebook `TechMind_Oficial.ipynb`) para
dentro de `techmind-api/artifacts/` antes de rodar ou fazer deploy.

```bash
cp "../modelo_classificacao.joblib" artifacts/
cp "../vectorizer_tfidf.joblib" artifacts/
```

(ajuste os caminhos conforme onde os arquivos `.joblib` mais recentes
estiverem salvos — geralmente após rodar o notebook completo no Colab
e baixá-los).

## Rodando localmente

### No Windows

```bash
# 1. Criar ambiente virtual (recomendado)
python -m venv venv
venv\Scripts\activate

# 2. Instalar dependências
pip install -r requirements.txt

# 3. Rodar a API
uvicorn app.main:app --reload
```

### No Mac / Linux

```bash
# 1. Criar ambiente virtual (recomendado)
python3 -m venv venv
source venv/bin/activate

# 2. Instalar dependências
pip install -r requirements.txt

# 3. Rodar a API
uvicorn app.main:app --reload
```

A API sobe em `http://127.0.0.1:8000` (também acessível por
`http://localhost:8000` — são o mesmo endereço). Documentação
interativa automática em `http://127.0.0.1:8000/docs`.

### Testando o endpoint

```bash
curl -X POST http://127.0.0.1:8000/conteudo \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Introdução ao Spring Boot",
    "texto": "Neste conteúdo, explicamos os fundamentos do Spring Boot, incluindo configuração de APIs REST, injeção de dependências e boas práticas de Clean Architecture para projetos Java."
  }'
```

Resposta esperada:

```json
{
  "categoria": "Backend",
  "probabilidade": 0.94,
  "tags": ["spring boot", "apis rest", "clean architecture", "java"],
  "resumo": "Neste conteúdo, explicamos os fundamentos do Spring Boot..."
}
```

## Rodando os testes

```bash
pip install pytest httpx
pytest tests/ -v
```

## Rodando com Docker (localmente)

```bash
docker build -t techmind-api .
docker run -p 8000:8000 techmind-api
```

## Deploy no Render (gratuito, sem cartão de crédito)

O Render oferece um plano free que não exige cartão de crédito para
serviços web via Docker. O único detalhe é que o serviço "dorme" após
15 minutos de inatividade, e demora ~30-60s para acordar na primeira
requisição seguinte — normal para o plano gratuito.

### Passo a passo

1. Acesse [render.com](https://render.com) e crie uma conta (pode ser
   com login do GitHub diretamente).

2. No dashboard, clique em **New +** → **Web Service**.

3. Conecte sua conta do GitHub e selecione o repositório
   `No-Country-simulation/G9-BR-Team-19`.

4. Em **Root Directory**, informe:
   ```
   Data Science/techmind-api
   ```
   (isso diz ao Render para tratar essa subpasta como raiz do projeto,
   já que o `Dockerfile` está lá dentro, não na raiz do repositório).

5. Em **Runtime**, selecione **Docker** (o Render deve detectar o
   `Dockerfile` automaticamente).

6. Em **Instance Type**, selecione **Free**.

7. Clique em **Create Web Service**.

8. Aguarde o build (a primeira vez demora alguns minutos, pois instala
   as dependências e monta a imagem Docker).

9. Quando terminar, o Render fornece uma URL pública — nesse projeto,
   ficou assim:
   ```
   https://techmind-api.onrender.com
   ```

10. Teste acessando `https://techmind-api.onrender.com/docs` no
    navegador — deve abrir a documentação interativa do FastAPI.

### ⚠️ Importante: artefatos `.joblib` no Git

Os arquivos `.joblib` precisam estar **commitados no repositório**
dentro de `artifacts/` para que o Render consiga copiá-los durante o
build do Docker (o `Dockerfile` faz `COPY artifacts/ ./artifacts/`).
Sempre que o modelo for retreinado, é preciso repetir esse fluxo:
baixar os novos `.joblib` → substituir em `artifacts/` → commit/push.
O Render detecta a mudança no GitHub e refaz o deploy automaticamente.

## Endpoints disponíveis

| Método | Rota | Descrição |
|---|---|---|
| GET | `/` | Mensagem de boas-vindas |
| GET | `/health` | Health check (usado por probes de liveness/readiness) |
| POST | `/conteudo` | Classifica um conteúdo técnico |
| GET | `/docs` | Documentação interativa (Swagger UI) |

## Status do projeto

- [x] API construída em FastAPI, com endpoint `POST /conteudo`
- [x] Testada localmente (Windows, com ambiente virtual)
- [x] Artefatos mais recentes do notebook (dataset com ruído, SVC
      calibrado, ~92% de acurácia) incluídos em `artifacts/`
- [x] Repositório conectado ao Render e deploy configurado
- [x] URL pública compartilhada com a equipe (Data Science e DevOps)
