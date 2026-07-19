"""
Módulo de inferência do TechMind.

Carrega os artefatos treinados (modelo + vectorizer) uma única vez,
na inicialização da API, e expõe a função predict_content() que
implementa o contrato do endpoint POST /conteudo.
"""

import os

import joblib
import numpy as np

from app.text_processing import limpar_texto, split_sentences

# ==========================================
# Caminhos dos artefatos
# ==========================================
ARTIFACTS_DIR = os.getenv("ARTIFACTS_DIR", os.path.join(os.path.dirname(__file__), "..", "artifacts"))
MODEL_PATH = os.path.join(ARTIFACTS_DIR, "modelo_classificacao.joblib")
VECTORIZER_PATH = os.path.join(ARTIFACTS_DIR, "vectorizer_tfidf.joblib")

# ==========================================
# Carregamento dos artefatos (uma única vez, no import do módulo)
# ==========================================
_model = None
_vectorizer = None
_feature_names = None


def load_artifacts() -> None:
    """Carrega o modelo e o vectorizer do disco para a memória."""
    global _model, _vectorizer, _feature_names

    if not os.path.exists(MODEL_PATH):
        raise FileNotFoundError(
            f"Modelo não encontrado em '{MODEL_PATH}'. "
            "Copie o arquivo modelo_classificacao.joblib gerado pelo notebook "
            "para a pasta 'artifacts/'."
        )
    if not os.path.exists(VECTORIZER_PATH):
        raise FileNotFoundError(
            f"Vectorizer não encontrado em '{VECTORIZER_PATH}'. "
            "Copie o arquivo vectorizer_tfidf.joblib gerado pelo notebook "
            "para a pasta 'artifacts/'."
        )

    _model = joblib.load(MODEL_PATH)
    _vectorizer = joblib.load(VECTORIZER_PATH)
    _feature_names = np.array(_vectorizer.get_feature_names_out())


def is_ready() -> bool:
    """Indica se os artefatos já foram carregados (usado no health check)."""
    return _model is not None and _vectorizer is not None


# ==========================================
# Extração de tags via TF-IDF
# ==========================================
def extract_tags(texto_limpo: str, top_n: int = 5) -> list[str]:
    vec = _vectorizer.transform([texto_limpo])
    scores = vec.toarray().flatten()
    top_idx = scores.argsort()[::-1][:top_n]
    tags = [_feature_names[i] for i in top_idx if scores[i] > 0]
    return tags


# ==========================================
# Geração de resumo extrativo (baseado em TF-IDF)
# ==========================================
def gerar_resumo(texto_bruto: str, num_frases: int = 1) -> str:
    frases = split_sentences(texto_bruto)
    if len(frases) <= num_frases:
        return " ".join(frases)

    frases_limpas = [limpar_texto(f) for f in frases]
    scores_frases = []
    for frase_limpa in frases_limpas:
        vec = _vectorizer.transform([frase_limpa])
        score = vec.toarray().sum()
        scores_frases.append(score)

    top_idx = np.argsort(scores_frases)[::-1][:num_frases]
    top_idx_ordenado = sorted(top_idx)
    resumo = " ".join([frases[i] for i in top_idx_ordenado])
    return resumo


# ==========================================
# Função de predição completa — contrato do endpoint POST /conteudo
# ==========================================
def predict_content(
    titulo: str,
    texto: str,
    top_n_tags: int = 5,
    num_frases_resumo: int = 1,
) -> dict:
    if _model is None or _vectorizer is None:
        raise RuntimeError("Artefatos não carregados. Chame load_artifacts() antes de prever.")

    titulo_limpo = limpar_texto(titulo)
    texto_limpo_input = limpar_texto(texto)
    conteudo_limpo = titulo_limpo + " " + texto_limpo_input

    conteudo_tfidf = _vectorizer.transform([conteudo_limpo])

    categoria_prevista = _model.predict(conteudo_tfidf)[0]

    if hasattr(_model, "predict_proba"):
        probabilidades = _model.predict_proba(conteudo_tfidf)[0]
        prob_dict = dict(zip(_model.classes_, probabilidades))
        probabilidade = round(float(prob_dict[categoria_prevista]), 4)
    else:
        probabilidade = None

    tags = extract_tags(conteudo_limpo, top_n=top_n_tags)
    resumo = gerar_resumo(texto, num_frases=num_frases_resumo)

    return {
        "categoria": str(categoria_prevista),
        "probabilidade": probabilidade,
        "tags": [str(t) for t in tags],
        "resumo": resumo,
    }
