from fastapi import FastAPI
from pydantic import BaseModel
import joblib

app = FastAPI()

modelo = joblib.load("modelo_classificacao.joblib")
vectorizer = joblib.load("vectorizer_tfidf.joblib")

class Conteudo(BaseModel):
    titulo: str
    texto: str

@app.post("/conteudo")
def classificar(conteudo: Conteudo):

    texto = conteudo.titulo + " " + conteudo.texto

    vetor = vectorizer.transform([texto])

    categoria = modelo.predict(vetor)[0]

    return {
        "categoria": categoria
    }