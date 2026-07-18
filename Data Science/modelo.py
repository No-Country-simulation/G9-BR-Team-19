import re
import unicodedata
import numpy as np
import joblib

melhor_modelo = joblib.load("modelo_classificacao.joblib")
vectorizer = joblib.load("vectorizer_tfidf.joblib")
feature_names = np.array(vectorizer.get_feature_names_out())

def normalizar(palavra):
    return unicodedata.normalize("NFKD", palavra).encode("ASCII", "ignore").decode("utf-8")

STOPWORDS_PT = set("""
a ao aos aquela aquelas aquele aqueles aquilo as até com como da das de dela
delas dele deles depois do dos e ela elas ele eles em entre era eram essa
essas esse esses esta estas este estes estou eu foi fomos for foram fosse
fossem fui há isso isto já lhe lhes mais mas me mesmo meu meus minha minhas
muito na nas nem no nos nossa nossas nosso nossos num numa não nós o os
ou para pela pelas pelo pelos por qual quando que quem se seu seus somos
sou sua suas são também te tem tem também teu teus tu tua tuas um uma
você vocês vos à às pode podem ser sendo sido têm foi ser será serão
""".split())

STOPWORDS_PT = {normalizar(p) for p in STOPWORDS_PT}

def limpar_texto(texto: str):
    texto = texto.lower()
    texto = unicodedata.normalize("NFKD", texto).encode("ASCII", "ignore").decode("utf-8")
    texto = re.sub(r"[^a-z\s]", " ", texto)
    texto = re.sub(r"\s+", " ", texto).strip()

    palavras = [
        p for p in texto.split()
        if p not in STOPWORDS_PT and len(p) > 2
    ]

    return " ".join(palavras)

def extract_tags(texto_limpo, top_n=5):
    vec = vectorizer.transform([texto_limpo])
    scores = vec.toarray().flatten()
    top_idx = scores.argsort()[::-1][:top_n]
    tags = [feature_names[i] for i in top_idx if scores[i] > 0]
    return tags

def split_sentences(texto):
    frases = re.split(r'(?<=[.!?])\s+', texto.strip())
    return [f for f in frases if f]

def gerar_resumo(texto_bruto, num_frases=1):
    frases = split_sentences(texto_bruto)

    if len(frases) <= num_frases:
        return " ".join(frases)

    frases_limpas = [limpar_texto(f) for f in frases]

    scores_frases = []

    for frase_limpa in frases_limpas:
        vec = vectorizer.transform([frase_limpa])
        score = vec.toarray().sum()
        scores_frases.append(score)

    top_idx = np.argsort(scores_frases)[::-1][:num_frases]
    top_idx_ordenado = sorted(top_idx)

    resumo = " ".join([frases[i] for i in top_idx_ordenado])

    return resumo


def predict_content(titulo, texto, top_n_tags=5, num_frases_resumo=1):
    titulo_limpo = limpar_texto(titulo)
    texto_limpo_input = limpar_texto(texto)
    conteudo_limpo = titulo_limpo + " " + texto_limpo_input

    conteudo_tfidf = vectorizer.transform([conteudo_limpo])

    categoria_prevista = melhor_modelo.predict(conteudo_tfidf)[0]

    if hasattr(melhor_modelo, "predict_proba"):
        probabilidades = melhor_modelo.predict_proba(conteudo_tfidf)[0]
        prob_dict = dict(zip(melhor_modelo.classes_, probabilidades))
        probabilidade = round(float(prob_dict[categoria_prevista]), 4)
    else:
        probabilidade = None

    tags = extract_tags(conteudo_limpo, top_n=top_n_tags)
    resumo = gerar_resumo(texto, num_frases=num_frases_resumo)

    return {
        "categoria": categoria_prevista,
        "probabilidade": probabilidade,
        "tags": tags,
        "resumo": resumo,
    }