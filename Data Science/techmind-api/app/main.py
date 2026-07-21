"""
TechMind API — classificação temática de conteúdos técnicos.

Endpoint principal: POST /conteudo
Recebe {titulo, texto} e retorna {categoria, probabilidade, tags, resumo}.
"""

import logging
from contextlib import asynccontextmanager

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware

from app import inference
from app.schemas import ConteudoRequest, ConteudoResponse, HealthResponse

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("techmind-api")


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Carrega o modelo e o vectorizer uma única vez, na subida da API."""
    logger.info("Carregando artefatos (modelo e vectorizer)...")
    inference.load_artifacts()
    logger.info("Artefatos carregados com sucesso.")
    yield
    # (nenhuma limpeza necessária no encerramento)


app = FastAPI(
    title="TechMind API",
    description=(
        "API de classificação temática de conteúdos técnicos. "
        "Recebe título e texto, e retorna categoria, probabilidade, tags e resumo."
    ),
    version="1.0.0",
    lifespan=lifespan,
)

# CORS liberado para facilitar integração com o front-end / testes.
# Em produção, restrinja allow_origins aos domínios reais do projeto.
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/", tags=["Health"])
def root():
    return {"message": "TechMind API está no ar. Veja /docs para a documentação interativa."}


@app.get("/health", response_model=HealthResponse, tags=["Health"])
def health():
    """
    Health check simples, útil para probes de liveness/readiness
    em ambientes de container (ex: OCI Container Instances / OKE).
    """
    return HealthResponse(
        status="ok" if inference.is_ready() else "artefatos não carregados",
        artefatos_carregados=inference.is_ready(),
    )


@app.post("/conteudo", response_model=ConteudoResponse, tags=["Classificação"])
def classificar_conteudo(payload: ConteudoRequest):
    """
    Classifica um conteúdo técnico, retornando categoria, probabilidade,
    tags (palavras-chave) e um resumo extrativo do texto.
    """
    if not inference.is_ready():
        raise HTTPException(status_code=503, detail="Artefatos ainda não carregados. Tente novamente em instantes.")

    try:
        resultado = inference.predict_content(payload.titulo, payload.texto)
    except Exception as exc:
        logger.exception("Erro ao processar predição")
        raise HTTPException(status_code=500, detail=f"Erro ao processar predição: {exc}") from exc

    return ConteudoResponse(**resultado)
