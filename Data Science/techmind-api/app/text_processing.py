"""
Módulo de processamento de texto do TechMind.

Replica exatamente a lógica usada no notebook de Data Science
(techmind_datascience.ipynb) para garantir que a API produza
resultados consistentes com o que foi validado no treinamento.
"""

import re
import unicodedata


def normalizar(palavra: str) -> str:
    """Remove acentuação de uma palavra."""
    return unicodedata.normalize("NFKD", palavra).encode("ASCII", "ignore").decode("utf-8")


# Lista de stopwords em português (customizada, sem dependência de download externo)
_STOPWORDS_PT_RAW = set(
    """
    a ao aos aquela aquelas aquele aqueles aquilo as até com como da das de dela
    delas dele deles depois do dos e ela elas ele eles em entre era eram essa
    essas esse esses esta estas este estes estou eu foi fomos for foram fosse
    fossem fui há isso isto já lhe lhes mais mas me mesmo meu meus minha minhas
    muito na nas nem no nos nossa nossas nosso nossos num numa não nós o os
    ou para pela pelas pelo pelos por qual quando que quem se seu seus somos
    sou sua suas são também te tem tem também teu teus tu tua tuas um uma
    você vocês vos à às pode podem ser sendo sido têm foi ser será serão
    """.split()
)

# Normaliza a lista de stopwords para bater com o texto já limpo (sem acento)
STOPWORDS_PT = {normalizar(p) for p in _STOPWORDS_PT_RAW}


def limpar_texto(texto: str) -> str:
    """
    Limpa um texto em português para uso no TF-IDF:
    - minúsculas
    - remove acentuação
    - remove pontuação e números
    - remove stopwords e palavras muito curtas (<=2 caracteres)
    """
    texto = texto.lower()
    texto = unicodedata.normalize("NFKD", texto).encode("ASCII", "ignore").decode("utf-8")
    texto = re.sub(r"[^a-z\s]", " ", texto)
    texto = re.sub(r"\s+", " ", texto).strip()
    palavras = [p for p in texto.split() if p not in STOPWORDS_PT and len(p) > 2]
    return " ".join(palavras)


def split_sentences(texto: str) -> list[str]:
    """Divide um texto em frases usando pontuação de final de sentença."""
    frases = re.split(r"(?<=[.!?])\s+", texto.strip())
    return [f for f in frases if f]
