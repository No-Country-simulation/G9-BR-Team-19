# G9-BR-Team-19
## TechMind - Organização Inteligente de Conhecimento Técnico 🧠

---

![Java](https://img.shields.io/badge/Java-25-ED8B00?logo=openjdk&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-4.1.0-6DB33F?logo=springboot&logoColor=white)
![Maven](https://img.shields.io/badge/Maven-3.9+-C71A36?logo=apachemaven&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.11-3776AB?logo=python&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-0.116+-009688?logo=fastapi&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Engine-2496ED?logo=docker&logoColor=white)
![Docker Compose](https://img.shields.io/badge/Docker_Compose-Enabled-2496ED?logo=docker&logoColor=white)
![Google Colab](https://img.shields.io/badge/Google_Colab-Notebook-F9AB00?logo=googlecolab&logoColor=white)
![Flyway](https://img.shields.io/badge/Flyway-Migrations-CC0200?logo=flyway&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?logo=fastapi&logoColor=white)
![Machine Learning](https://img.shields.io/badge/Machine-Learning-purple)
![Git](https://img.shields.io/badge/Git-F05032?logo=git&logoColor=white)

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 📋 Sobre o Projeto

---
O **TechMind API** é uma solução de backend desenvolvida para a orquestração e gerenciamento inteligente de conteúdos técnicos. A aplicação atua como uma ponte eficiente entre as requisições enviadas pelo usuário e um modelo preditivo de Inteligência Artificial baseado em Python, garantindo a validação dos dados de entrada, a classificação automatizada e a organização estruturada dessas informações.
<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

### 🎯 Objetivos

---
O backend atua como uma camada intermediária entre o cliente e a API de Machine Learning.

Seu papel é:

- Receber um conteúdo técnico (título e texto);
- Validar os dados enviados;
- Enviar a requisição para a API de classificação desenvolvida em FastAPI;
- Receber a resposta do modelo de IA;
- Armazenar temporariamente o resultado;
- Disponibilizar consultas através de endpoints REST.


<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 🏗️ Arquitetura da Solução

---

```text
┌─────────────┐
│   Cliente   │  (Postman/cURL/Frontend)
└──────┬──────┘
       │ POST /api/conteudos/processar
       ▼
┌─────────────────────┐  
│   Java API :8080    │  ✅ Recebe requisições REST
│   Spring Boot 4.1.0 │  ✅ Valida dados (Jakarta / Bean Validation)
│                     │  ✅ Trata exceções globalmente
└──────┬──────────────┘  ✅ Gerenciamento da API
       │
       ▼
┌─────────────────────┐  ✅ Alternância de Ambiente (Modo Mock ativo)
│   API de ML         │  ✅ Extração de palavras-chave
│   FastAPI (Python)  │  ✅ Geração de resumo 
└──────┬──────────────┘  ✅ Cálculo da probabilidade
       │
       ▼
┌─────────────────────┐
│   Modelo de IA      │  ✅ Vetorização TF-IDF
│   Mock/Real Service │  ✅ Classificação e Sumarização de Conteúdo
└─────────────────────┘  ✅ Retorna Categoria, Tags e Probabilidade
```

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">


## 🛠️ Tecnologias

---

### Backend (Java)
*   ☕ **Java 25**
*   🍃 **Spring Boot 4.1.0**
*   🔧 **Maven** (Compilação)
*   🔒 **RestClient + Validação (Jakarta)**
*   📊 **Java Stream API** (Filtros em memória)
*   🧰 **Lombok**

### Integração de ML (Python)
*   🐍 **Python 3.11**
*   ☁️ **Google Colab** (Treinamento do modelo)
*   ⚡ **FastAPI**
*   🔄 **IA Wrapper API**
*   ✅ **Pydantic** (Validação)

### DevOps & Qualidade
*   🐳 **Docker + Docker Compose**
*   ✅ **JUnit 5 + Pytest**
*   🌱 **Git**
*   📊 **Relatórios de Cobertura**

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 📁 Estrutura do Projeto

---

```
backend/
│
├── src/
│   ├── main/
│   │
│   ├── java/com/techmind/team19/
│   │   ├── controller/
│   │   │      ApiController.java
│   │   │
│   │   ├── dto/
│   │   │      DadosConsultaConteudos.java
│   │   │      DadosRespostaConteudo.java
│   │   │
│   │   ├── exception/
│   │   │      GlobalException.java
│   │   │
│   │   ├── service/
│   │   │      ConteudoStorageService.java
│   │   │      ServiceDados.java
│   │   │
│   │   └── Team19Application.java
│   │
│   └── resources/
│          application.properties
│
├── Dockerfile
├── docker-compose.yml
├── pom.xml
└── README.md
```
<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 🔗 Integração com a API de IA

---

O backend comunica-se com a API desenvolvida pela equipe de Data Science para realizar a classificação automática de conteúdos técnicos.

###  🌐 API Pública

https://techmind-api.onrender.com

### 📖 Swagger

https://techmind-api.onrender.com/docs


### 📦 A resposta da API contém

- categoria
- probabilidade
- tags
- resumo

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## ⚙️ Configuração

---

As propriedades da aplicação são definidas no arquivo `application.properties`.

```properties
spring.application.name=team19

model.python.url=https://techmind-api.onrender.com/conteudo
model.python.mock-enabled=true
```

### 🔹 Propriedades

| Propriedade | Descrição |
|------------|-----------|
| `model.python.url` | URL da API de Machine Learning utilizada pelo backend. |
| `model.python.mock-enabled` | Quando `true`, utiliza respostas simuladas para desenvolvimento. Quando `false`, envia requisições para a API FastAPI. |

## ▶️ Executando o Projeto

### 📋 Pré-requisitos

- Java 21
- Maven 3.9+
- Git

### 📥 Clone o projeto

```bash
git clone <url-do-repositorio>
```
### 📂 Entre na pasta

```bash
cd backend
```

### ▶️ Execute

```bash
./mvnw spring-boot:run
```

ou

```bash
mvn spring-boot:run
```

### A aplicação ficará disponível em:

```
http://localhost:8080
```
<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 🧩 Implementação de Padrões de Projeto & Componentes

---

A aplicação foi desenhada seguindo as melhores práticas de desenvolvimento corporativo em Java, garantindo baixo acoplamento, alta coesão e facilidade de manutenção.

| Padrão / Componente | Implementação | Propósito |
| :--- | :--- | :--- |
| **Padrão DTO** | `DadosConsultaConteudos`, `DadosRespostaConteudo` | Desacoplamento e segurança na trafegabilidade de dados entre a API Java, o cliente e os serviços externos. |
| **Camada de Serviço** | `ServiceDados` | Centraliza as regras de negócio do sistema, a orquestração de dados e a comunicação via HTTP Client. |
| **Camada de Armazenamento** | `ConteudoStorageService` | Centraliza o gerenciamento, persistência em memória e aplicação de filtros dinâmicos com a Stream API. |
| **Tratamento Global** | `GlobalException` com `@RestControllerAdvice` | Intercepta exceções em tempo de execução, garantindo respostas padronizadas e códigos de status HTTP sem expor o stacktrace. |

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 📡 Endpoints (Documentação da API)

---

### URL base
```text
http://localhost:8080/api/conteudos
```
Corpo de solicitação

**POST**

```json
{
  "titulo": "Introdução ao Spring Boot",
  "texto": "Neste conteúdo explicamos APIs REST utilizando Spring Boot."
}
```

| Campo | Tipo | Validação | Descrição |
| :--- | :--- | :--- | :--- |
| `titulo` | `string` | `@NotBlank` | Título identificador do conteúdo enviado |
| `texto` | `string` | `@NotBlank` | Corpo do texto bruto a ser processado pela IA |

Corpo da resposta (200 OK)

```json
{
  "categoria": "Backend",
  "probabilidade": 0.94,
  "tags": [
    "java",
    "spring boot",
    "api rest"
  ],
  "resumo": "Neste conteúdo explicamos APIs REST utilizando Spring Boot."
}
```
Listar Todos os Conteúdos processados

**GET**

```
/api/conteudos
```

Corpo da resposta (200 OK - Lista de Resultados)

``` json
 {
    "categoria": "Backend",
    "probabilidade": 0.94,
    "tags": [
      "java",
      "spring boot",
      "api rest"
    ],
    "resumo": "Neste conteúdo explicamos APIs REST utilizando Spring Boot."
  }
```
---

## Buscar por categoria

**GET**

```
/api/conteudos/categoria/{categoria}
```

Exemplo

```
GET /api/conteudos/categoria/Backend
```

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 🧪 Testes

O projeto foi estruturado para permitir a criação de testes unitários e de integração utilizando o ecossistema de testes do Spring Boot.

### Tecnologias de teste disponíveis

- ✅ Spring Boot Test
- ✅ Spring Web MVC Test
- ✅ Spring Data JPA Test
- ✅ Flyway Test

### Cenários previstos para validação

- ✔️ Validação dos campos obrigatórios (`@NotBlank`)
- ✔️ Processamento de conteúdos
- ✔️ Listagem de conteúdos processados
- ✔️ Busca por categoria
- ✔️ Tratamento global de exceções
- ✔️ Integração com a API de Machine Learning

> Os testes podem ser executados utilizando o Maven:

```bash
./mvnw test
```

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## ⚠️ Tratamento de Exceções

---

A aplicação utiliza `@RestControllerAdvice` para centralizar o tratamento das exceções e padronizar as respostas da API.

### Erros tratados

| Código HTTP | Situação |
|-------------|----------|
| 🔴 400 | Requisição inválida |
| 🟠 404 | Recurso não encontrado |
| 🔴 500 | Erro interno do servidor |
| 🟡 Validação | Campos obrigatórios não informados |

### Exemplo

```json
{
    "status":400,
    "message":"Texto obrigatório"
}
```
<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 💾 Armazenamento

---

Atualmente os conteúdos classificados são armazenados apenas em memória utilizando uma lista (`ArrayList`).

⚠️Não há persistência em banco de dados nesta versão.

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 🐳 Docker

---

Build

```bash
docker build -t techmind-backend .
```

Executar

```bash
docker run -p 8080:8080 techmind-backend
```

Ou utilizando Docker Compose

```bash
docker compose up
```

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 🚀 Melhorias Futuras

---

- Integração com banco de dados
- Autenticação com JWT
- Cache de respostas
- Documentação com Swagger/OpenAPI
- Testes unitários
- Testes de integração
- Deploy em ambiente de produção
- Persistência dos conteúdos processados

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 👥 Equipes

---

### 💻 Backend

- Desenvolvimento da API REST em Spring Boot
- Integração com a API de Machine Learning
- Validação dos dados
- Tratamento global de exceções
- Gerenciamento das requisições

### 🤖 Data Science

- Desenvolvimento do modelo de Machine Learning
- Processamento de Linguagem Natural (NLP)
- Classificação dos conteúdos
- Extração de palavras-chave
- Geração de resumos
- Disponibilização da API FastAPI

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 📌 Status do Projeto

---

O projeto encontra-se em desenvolvimento e atualmente possui:

- ✅ API REST funcional
- ✅ Integração com a API FastAPI
- ✅ Modo Mock para desenvolvimento
- ✅ Validação dos dados de entrada
- ✅ Tratamento global de exceções
- ✅ Armazenamento temporário em memória

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 📄 Licença

---

Projeto desenvolvido para fins acadêmicos durante o programa **No Country - Team 19**.

