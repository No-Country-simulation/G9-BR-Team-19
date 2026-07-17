# Integração do Modelo de Machine Learning com Spring Boot

## Visão Geral

Este documento descreve como foi realizada a integração entre o modelo de Machine Learning desenvolvido em Python e a API Java Spring Boot.

O objetivo da integração é permitir que o sistema Java envie um conteúdo (título e texto) para um serviço Python responsável por classificar o conteúdo utilizando o modelo treinado.

A arquitetura final ficou da seguinte forma:

```
Cliente
    │
    ▼
Spring Boot
    │
    │ POST /conteudo
    ▼
FastAPI (Python)
    │
    ▼
Modelo treinado (.joblib)
    │
    ▼
Resposta JSON
    │
    ▼
Spring Boot
    │
    ▼
Cliente
```

---

# Estrutura do projeto Python

```
Data Science/

│── app.py
│── modelo.py
│── modelo_classificacao.joblib
│── vectorizer_tfidf.joblib
│── TechMind_Oficial.ipynb
```

## Responsabilidade de cada arquivo

### TechMind_Oficial.ipynb

Notebook utilizado durante o desenvolvimento do projeto.

Responsável por:

- criação da base sintética;
- limpeza dos dados;
- treinamento dos modelos;
- comparação dos algoritmos;
- avaliação da acurácia;
- geração dos artefatos `.joblib`.

Este arquivo **não é utilizado pela API**.

---

### modelo_classificacao.joblib

Modelo treinado.

Foi salvo utilizando Joblib e é carregado pela API para realizar previsões.

---

### vectorizer_tfidf.joblib

Vetorizador TF-IDF utilizado durante o treinamento.

É necessário para transformar o texto recebido em um vetor numérico antes da classificação.

---

### modelo.py

Arquivo criado especificamente para produção.

Contém apenas as funções necessárias para utilizar o modelo treinado.

Foram movidas do notebook apenas as funções de inferência:

- limpar_texto()
- extract_tags()
- gerar_resumo()
- predict_content()

Também realiza o carregamento do:

- modelo_classificacao.joblib
- vectorizer_tfidf.joblib

Este arquivo **não realiza treinamento**.

---

### app.py

Responsável apenas por disponibilizar uma API REST utilizando FastAPI.

Recebe:

```json
{
    "titulo": "...",
    "texto": "..."
}
```

e retorna:

```json
{
    "categoria": "...",
    "probabilidade": 0.91,
    "tags": [
        "...",
        "..."
    ],
    "resumo": "..."
}
```

---

# Por que foi criado o arquivo modelo.py?

O notebook (.ipynb) possui centenas de linhas contendo:

- treinamento;
- geração de gráficos;
- avaliação;
- criação da base de dados;
- comparação de modelos.

Caso o notebook inteiro fosse importado pela API, todo esse código seria executado sempre que a aplicação fosse iniciada.

Isso causaria:

- demora para iniciar;
- consumo desnecessário de memória;
- necessidade de instalar bibliotecas utilizadas apenas durante o treinamento;
- possibilidade de erros durante a inicialização.

Por isso foi criado o arquivo **modelo.py**, contendo apenas a parte responsável por utilizar o modelo já treinado.

Essa é a abordagem normalmente utilizada em aplicações de produção.

---

# Bibliotecas utilizadas

Instalação das dependências:

```bash
pip install fastapi uvicorn joblib numpy scikit-learn
```

Caso seja necessário utilizar o notebook novamente:

```bash
pip install pandas matplotlib notebook jupyter
```

---

# Executando a API Python

Dentro da pasta Data Science:

```bash
uvicorn app:app --reload
```

A API ficará disponível em:

```
http://127.0.0.1:8000
```

Documentação automática:

```
http://127.0.0.1:8000/docs
```

---

# Endpoint disponível

## POST /conteudo

Entrada

```json
{
    "titulo": "Curso de Flutter",
    "texto": "Aprenda Flutter utilizando Dart e integração com APIs."
}
```

Saída

```json
{
    "categoria": "Mobile",
    "probabilidade": 0.93,
    "tags": [
        "flutter",
        "dart",
        "mobile"
    ],
    "resumo": "Aprenda Flutter utilizando Dart e integração com APIs."
}
```

---

# Integração com Spring Boot

O Spring Boot utiliza o RestClient para consumir a API Python.

application.properties

```properties
model.python.url=http://127.0.0.1:8000/conteudo
model.python.mock-enabled=false
```

Service:

```java
return restClient.post()
        .uri(dadosUrl)
        .body(dados)
        .retrieve()
        .body(DadosRespostaConteudo.class);
```

O objeto enviado é:

```java
public record DadosConsultaConteudos(
    String titulo,
    String texto
){}
```

O retorno esperado é:

```java
public record DadosRespostaConteudo(
    String categoria,
    Double probabilidade,
    List<String> tags,
    String resumo
){}
```

---

# Fluxo completo da aplicação

```
Usuário
    │
    ▼
Spring Boot
    │
    ▼
ServiceDados
    │
    ▼
RestClient
    │
    ▼
POST http://127.0.0.1:8000/conteudo
    │
    ▼
FastAPI
    │
    ▼
predict_content()
    │
    ▼
TF-IDF
    │
    ▼
Modelo treinado (.joblib)
    │
    ▼
Categoria + Probabilidade + Tags + Resumo
    │
    ▼
Spring Boot
    │
    ▼
Resposta ao cliente
```

---

# Benefícios da arquitetura

- Separação entre treinamento e produção.
- Inicialização rápida da API Python.
- Reutilização do modelo treinado.
- Integração simples com Spring Boot.
- Fácil atualização do modelo sem alterar o código Java.
- Arquitetura escalável, permitindo substituir o modelo futuramente apenas trocando os arquivos `.joblib`.

---

# Observações

- O notebook (`TechMind_Oficial.ipynb`) continua sendo utilizado apenas para treinamento e geração de novos modelos.
- Sempre que um novo modelo for treinado, basta substituir os arquivos:
  - `modelo_classificacao.joblib`
  - `vectorizer_tfidf.joblib`
- Não é necessário alterar o código do Spring Boot nem da API FastAPI para utilizar um novo modelo, desde que a estrutura de entrada e saída permaneça a mesma.