from fastapi import FastAPI
from pydantic import BaseModel
from modelo import predict_content

app = FastAPI()

class Conteudo(BaseModel):
    titulo: str
    texto: str

@app.post("/conteudo")
def classificar(conteudo: Conteudo):
    return predict_content(conteudo.titulo, conteudo.texto)