"""
Testes básicos da API TechMind.

Rodar com: pytest tests/ (a partir da raiz do projeto, com os artefatos
já colocados em artifacts/).
"""

import pytest
from fastapi.testclient import TestClient

from app.main import app


@pytest.fixture
def client():
    # Usar como context manager dispara o lifespan (carrega os artefatos)
    with TestClient(app) as c:
        yield c


def test_health(client):
    response = client.get("/health")
    assert response.status_code == 200
    assert "status" in response.json()


def test_conteudo_backend(client):
    payload = {
        "titulo": "Introdução ao Spring Boot",
        "texto": (
            "Neste conteúdo, explicamos os fundamentos do Spring Boot, "
            "incluindo configuração de APIs REST, injeção de dependências "
            "e boas práticas de Clean Architecture para projetos Java."
        ),
    }
    response = client.post("/conteudo", json=payload)
    assert response.status_code == 200

    data = response.json()
    assert "categoria" in data
    assert "probabilidade" in data
    assert "tags" in data
    assert "resumo" in data
    assert isinstance(data["tags"], list)


def test_conteudo_devops(client):
    payload = {
        "titulo": "Como funciona o Kubernetes",
        "texto": (
            "Este material aborda a orquestração de containers com Kubernetes, "
            "cobrindo pipelines de CI/CD, escalabilidade automática e "
            "monitoramento de infraestrutura em produção."
        ),
    }
    response = client.post("/conteudo", json=payload)
    assert response.status_code == 200


def test_conteudo_campos_obrigatorios(client):
    response = client.post("/conteudo", json={"titulo": "Só título"})
    assert response.status_code == 422  # falta o campo 'texto'
