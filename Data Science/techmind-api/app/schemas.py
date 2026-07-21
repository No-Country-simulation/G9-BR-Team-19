"""Schemas Pydantic (request/response) da API TechMind."""

from typing import List, Optional

from pydantic import BaseModel, Field


class ConteudoRequest(BaseModel):
    titulo: str = Field(..., min_length=1, description="Título do conteúdo técnico.")
    texto: str = Field(..., min_length=1, description="Corpo do conteúdo técnico.")

    class Config:
        json_schema_extra = {
            "example": {
                "titulo": "Introdução ao Spring Boot",
                "texto": (
                    "Neste conteúdo, explicamos os fundamentos do Spring Boot, "
                    "incluindo configuração de APIs REST, injeção de dependências "
                    "e boas práticas de Clean Architecture para projetos Java."
                ),
            }
        }


class ConteudoResponse(BaseModel):
    categoria: str = Field(..., description="Categoria prevista pelo modelo.")
    probabilidade: Optional[float] = Field(
        None, description="Confiança do modelo na categoria prevista (0 a 1)."
    )
    tags: List[str] = Field(default_factory=list, description="Palavras-chave extraídas do conteúdo.")
    resumo: str = Field(..., description="Resumo extrativo do texto original.")

    class Config:
        json_schema_extra = {
            "example": {
                "categoria": "Backend",
                "probabilidade": 0.9421,
                "tags": ["spring boot", "apis rest", "clean architecture", "java", "dependencias"],
                "resumo": "Neste conteúdo, explicamos os fundamentos do Spring Boot.",
            }
        }


class HealthResponse(BaseModel):
    status: str
    artefatos_carregados: bool
