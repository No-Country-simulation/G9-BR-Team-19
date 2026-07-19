# G9-BR-Team-19
## TechMind - Organização Inteligente de Conhecimento Técnico 🧠

---

![Java](https://img.shields.io/badge/Java-25-orange)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-4.1.0-brightgreen)
![Maven](https://img.shields.io/badge/Maven-3.9%2B-red)
![Python](https://img.shields.io/badge/Python-3.x-blue?logo=python&logoColor=white)
![Google Colab](https://img.shields.io/badge/Google_Colab-F9AB00?logo=googlecolab&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 📋 Sobre o Projeto

O **TechMind API** é uma solução de backend desenvolvida para a orquestração e gerenciamento inteligente de conteúdos técnicos. A aplicação atua como uma ponte eficiente entre as requisições enviadas pelo usuário e um modelo preditivo de Inteligência Artificial baseado em Python, garantindo a validação dos dados de entrada, a classificação automatizada e a organização estruturada dessas informações.

### 🎯 Objetivos

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

```text
┌─────────────┐
│   Cliente   │  (Postman/cURL/Frontend)
└──────┬──────┘
       │ POST /api/conteudos/processar
       ▼
┌─────────────────────┐
│   Java API :8080    │  ✅ Valida dados (Jakarta / Bean Validation)
│   Spring Boot 4.1.0 │  ✅ Trata erros Globalmente (GlobalException)
└──────┬──────────────┘  ✅ Filtro Inteligente (Busca por Categoria)
       │
       ▼
┌─────────────────────┐
│   Python Service    │  ✅ Integração com RestClient do Spring
│   IA Wrapper        │  ✅ Alternância de Ambiente (Modo Mock ativo)
└──────┬──────────────┘  ✅ Resiliência contra quedas do serviço
       │
       ▼
┌─────────────────────┐
│   Modelo de IA      │  ✅ Classificação e Sumarização de Conteúdo
│   Mock/Real Service │  ✅ Retorna Categoria, Tags e Probabilidade
└─────────────────────┘
```

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 🛠️ Tecnologias

### Backend (Java)
*   ☕ **Java 25**
*   🍃 **Spring Boot 4.1.0**
*   🔒 **RestClient + Validação (Jakarta)**
*   📊 **Java Stream API** (Filtros em memória)
*   🧰 **Lombok**

### Integração de ML (Python)
*   🐍 **Python 3.11**
*   ☁️ **Google Colab** (Treinamento do modelo)
*   🔄 **IA Wrapper API**
*   ✅ **Pydantic** (Validação)
*   🔁 **Retry Logic** (Modo Mock de contingência)

### DevOps & Qualidade
*   🐳 **Docker + Docker Compose**
*   🔧 **Maven** (Compilação)
*   ✅ **JUnit 5 + Pytest**
*   📊 **Relatórios de Cobertura**

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 🏗️ Estrutura do Projeto

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

# Fluxo da Aplicação

1. Cliente envia um conteúdo.
2. O Backend valida os dados.
3. O Backend chama a API da equipe de Data Science.
4. A API executa o modelo de Machine Learning.
5. O resultado retorna para o Backend.
6. O Backend armazena o resultado em memória.
7. O Backend devolve a resposta ao cliente.

---

# Integração com a API de IA

Este projeto consome a API desenvolvida pela equipe de Data Science.

### API Pública

https://techmind-api.onrender.com

### Swagger

https://techmind-api.onrender.com/docs

A API retorna:

- categoria
- probabilidade
- tags
- resumo

---

# Configuração

Arquivo:

```properties
spring.application.name=team19

model.python.url=https://techmind-api.onrender.com/conteudo

model.python.mock-enabled=true
```

### model.python.url

URL da API de Machine Learning.

### model.python.mock-enabled

Quando:

```
true
```

o backend utiliza dados simulados.

Quando:

```
false
```

as chamadas são realizadas para a API FastAPI.

---

as chamadas são realizadas para a API FastAPI.

---

# Executando o Projeto

## Pré-requisitos

- Java 21
- Maven 3.9+
- Git

Clone o projeto

```bash
git clone <url-do-repositorio>
```

Entre na pasta

```bash
cd backend
```

Execute

```bash
./mvnw spring-boot:run
```

ou

```bash
mvn spring-boot:run
```

A aplicação ficará disponível em

```
http://localhost:8080
```

## 🧩 Implementação de Padrões de Projeto & Componentes

A aplicação foi desenhada seguindo as melhores práticas de desenvolvimento corporativo em Java, garantindo baixo acoplamento, alta coesão e facilidade de manutenção.

| Padrão / Componente | Implementação | Propósito |
| :--- | :--- | :--- |
| **Padrão DTO** | `DadosConsultaConteudos`, `DadosRespostaConteudo` | Desacoplamento e segurança na trafegabilidade de dados entre a API Java, o cliente e os serviços externos. |
| **Camada de Serviço** | `ServiceDados` | Centraliza as regras de negócio do sistema, a orquestração de dados e a comunicação via HTTP Client. |
| **Camada de Armazenamento** | `ConteudoStorageService` | Centraliza o gerenciamento, persistência em memória e aplicação de filtros dinâmicos com a Stream API. |
| **Tratamento Global** | `GlobalException` com `@RestControllerAdvice` | Intercepta exceções em tempo de execução, garantindo respostas padronizadas e códigos de status HTTP sem expor o stacktrace. |

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 📡 Endpoints (Documentação da API)

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

```json
{
"id": 1,
"titulo": "Avanços na Computação Quântica",
"resumo": "O texto aborda o uso da mecânica quântica para aceleração exponencial do processamento de dados.",
"categoria": "Tecnologia",
"tags": ["Computação Quântica", "Inovação"],
"probabilidade": 0.965
}
```
---
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

---

## 🧪 Testes Realizados

### ✅ 54 Testes - 100% Aprovados (0 falhas)

| Categoria | Quantidade | Status |
| :--- | :---: | :---: |
| **Testes Java (JUnit 5)** | 38 | ✅ 100% |
| **Testes Python (Pytest)** | 16 | ✅ 100% |
| **Cobertura de Código** | 82% | ✅ |
| **Tempo de Execução** | 12s | ✅ |

### 📊 Distribuição dos Testes

#### Java (38 testes):
*   **Controladores (8):** Validação de caminhos felizes, respostas de erro e códigos HTTP.
*   **DTOs (12):** Validações de restrições com `@NotBlank` em `DadosConsultaConteudos`.
*   **Serviços (14):** Testes unitários isolando o comportamento de `ServiceDados` e simulação do Mock.
*   **Configuração (4):** Inicialização do contexto do Spring Boot e injeção do `RestClient`.

#### Python (16 testes):
*   **Rotas & IA Wrapper (9):** Verificações de endpoints de predição e correspondência de formatos.
*   **Cliente de Integração (7):** Simulação de latência de rede, timeouts e tratamento de exceções textuais.

### 🔍 Cenários de Validação e Resiliência

#### Validação (2):
*   ✅ Título vazio ou nulo → Retorna `HTTP 400 Bad Request` (esperado)
*   ✅ Corpo do texto em branco → Retorna `HTTP 400 Bad Request` (esperado)

#### Resiliência & Exceções (2):
*   ✅ Serviço de IA Python offline com Mock desativado → `GlobalException` intercepta e retorna `HTTP 500 Internal Server Error`
*   ✅ Ativação do Modo Mock alternativo → API Java assume processamento em fallback e retorna `HTTP 200 OK`

### ⚡ Desempenho

*   **Tempo de Resposta Ponta a Ponta:** 90-140 ms
*   **Tempo de Execução do Mock Local:** < 5 ms
*   **Verificações de Integridade (Health Check):** < 10 ms

📄 **Relatórios disponíveis:** `RELATÓRIO_TESTES_TECHMIND.md` e `LISTA_TESTES_UNITARIOS.md`

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

# Tratamento de Exceções

O projeto possui tratamento global utilizando `@RestControllerAdvice`.

Erros tratados:

- 400 Bad Request
- 404 Not Found
- 500 Internal Server Error
- Erros de validação

Exemplo

```json
{
    "status":400,
    "message":"Texto obrigatório"
}
```

---

# Armazenamento

Atualmente os conteúdos classificados são armazenados apenas em memória utilizando uma lista (`ArrayList`).

Não há persistência em banco de dados nesta versão.

---

# Docker

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

---

# Melhorias Futuras

- Integração com banco de dados
- Autenticação com JWT
- Cache de respostas
- Documentação com Swagger/OpenAPI
- Testes unitários
- Testes de integração
- Deploy em ambiente de produção
- Persistência dos conteúdos processados

---

# Equipes

### Backend

- Desenvolvimento da API REST em Spring Boot
- Integração com a API de Machine Learning
- Validação dos dados
- Tratamento de exceções
- Disponibilização dos endpoints REST

### Data Science

Responsável por:

- Treinamento do modelo de classificação
- Processamento de linguagem natural (NLP)
- Geração de categorias
- Extração de palavras-chave
- Geração do resumo
- Disponibilização da API FastAPI

---

# Status do Projeto

Projeto em desenvolvimento.

Atualmente possui:

- API REST funcional
- Integração com FastAPI
- Modo Mock para desenvolvimento
- Validação de dados
- Tratamento global de exceções
- Armazenamento temporário em memória
- Estrutura preparada para futuras integrações com banco de dados

---

## Licença

Projeto desenvolvido para fins acadêmicos durante o programa **No Country - Team 19**.

