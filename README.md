# G9-BR-Team-19
## TechMind - Organização Inteligente de Conhecimento Técnico 🧠

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

![HTML5](https://img.shields.io/badge/HTML5-E34F26?logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?logo=css3&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?logo=javascript&logoColor=black)
![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![Java](https://img.shields.io/badge/Java-25-ED8B00?logo=openjdk&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-4.1.0-6DB33F?logo=springboot&logoColor=white)
![Maven](https://img.shields.io/badge/Maven-3.9+-C71A36?logo=apachemaven&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?logo=mysql&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?logo=postgresql&logoColor=white)
![Flyway](https://img.shields.io/badge/Flyway-Migrations-CC0200?logo=flyway&logoColor=white)
![Swagger](https://img.shields.io/badge/Swagger-85EA2D?logo=swagger&logoColor=black)
![Python](https://img.shields.io/badge/Python-3.11-3776AB?logo=python&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-0.116+-009688?logo=fastapi&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Engine-2496ED?logo=docker&logoColor=white)
![Docker Compose](https://img.shields.io/badge/Docker_Compose-Enabled-2496ED?logo=docker&logoColor=white)
![Render](https://img.shields.io/badge/Render-46E3B7?logo=render&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?logo=git&logoColor=white)

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 📋 Sobre o Projeto

---
O **TechMind** é uma solução completa (Frontend Web, Aplicativo Mobile, Backend REST e Machine Learning) desenvolvida para a orquestração e gerenciamento inteligente de conteúdos técnicos. A aplicação transforma textos em um acervo categorizado, resumido e tagueado por Inteligência Artificial, permitindo a fácil consulta, classificação e reutilização do conhecimento.

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

### 🎯 Objetivos

---
A aplicação integra interfaces de usuário (Web SPA e Mobile Flutter), uma camada intermediária REST em Spring Boot e uma API de Machine Learning em Python.

Seu papel é:

- Oferecer interfaces web e mobile responsivas para envio e visualização de análises;
- Permitir a navegação entre a Landing Page inicial, o ecossistema web e o aplicativo Flutter;
- Receber conteúdos técnicos (título e texto) enviados pelos clientes;
- Validar os dados e encaminhá-los para a API de IA desenvolvida em FastAPI;
- Receber a resposta do modelo (Categoria, Tags, Resumo e Probabilidade);
- Persistir as análises em banco de dados relacional (MySQL/PostgreSQL);
- Exibir os resultados dinamicamente no acervo (Bibliotech).

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 🏗️ Arquitetura da Solução

---

```text

┌─────────────────────┐    ┌─────────────────────┐
│    Frontend Web     │    │   App Mobile        │  ✅ Interface SPA Web (HTML5, CSS3 3D, Vanilla JS)
│   (SPA Vanilla JS)  │    │   (Flutter / Dart)  │  ✅ App Mobile Multiplataforma (Android & iOS)
└──────────┬──────────┘    └──────────┬──────────┘  ✅ Consumo Assíncrono de API via HTTP/Fetch
           │                          │
           └────────────┬─────────────┘
                        │ POST /api/conteudos/processar
                        ▼
          ┌───────────────────────────┐
          │   Java API (Spring Boot)  │  ✅ Recebe e valida requisições REST (Jakarta Validation)
          │   Serviço REST / Render   │  ✅ Documentação interativa integrada (Swagger/OpenAPI 3)
          └──────┬─────────────┬──────┘  ✅ Migrações de banco via Flyway e tratamento global de erros
                 │             │
        SQL CRUD │             │ HTTP Request (REST Client)
                 ▼             ▼
┌─────────────────────┐   ┌─────────────────────┐
│  Banco Relacional   │   │   API de ML         │  ✅ Alternância de ambiente (Modo Mock / Produção)
│ (MySQL/PostgreSQL)  │   │   FastAPI (Python)  │  ✅ Extração de palavras-chave, resumo e probabilidade
└─────────────────────┘   └──────────┬──────────┘  ✅ Hospedada em nuvem (Render/OCI)
                                     │
                                     ▼
                          ┌─────────────────────┐
                          │    Modelo de IA     │  ✅ Vetorização TF-IDF
                          │  (Classificador)    │  ✅ Classificação e Sumarização de Conteúdo
                          └─────────────────────┘  ✅ Retorna Categoria, Tags e Probabilidade

```

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">


## 🛠️ Tecnologias

---
### Frontend (Web) & Mobile
*   🌐 **HTML5** (Semântico e estruturado)
*   🎨 **CSS3** (Variáveis, Flexbox, Grid, Animações 3D preserve-3d, Responsividade)
*   ⚡ **JavaScript Vanilla** (ES6+) (Manipulação de DOM, Fetch API, SPA Routing)
*   📱  **Flutter & Dart** (Aplicativo Mobile Multiplataforma Android/iOS)
*   🔤 **Google Fonts** (Fonte Iceland) & Font Awesome (Ícones)

### Backend (Java)
*   ☕ **Java 25**
*   🍃 **Spring Boot 4.1.0**
*   🔧 **Maven** (Compilação)
*   🔒 **RestClient + Validação** (Jakarta)
*   🗄️ **Spring Data JPA & Hibernate**
*   🐬 **MySQL / PostgreSQL** (Banco de Dados Relacional)
    🦅 **Flyway** (Gerenciamento de Migrações do Banco)
*   📖 **Swagger UI / OpenAPI 3** (Documentação da API)
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
*   ☁️ **Render / OCI** (Hospedagem e Deploy Cloud)
*   ✅ **JUnit 5 + Pytest**
*   🌱 **Git**
*   📊 **Relatórios de Cobertura**

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 📁 Estrutura do Projeto

---

```text
techmind/
│
├── mobile/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── models/
│   │   ├── screens/
│   │   └── services/
│   └──  pubspec.yaml
│   
│
├── frontend/
│   ├── assets/
│   │      ai.png
│   │      background.png
│   │      brain.png
│   │      knowledge.png
│   ├── index.html
│   ├── style.css
│   └── app.js
│
├── backend/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/techmind/team19/
│   │   │   │   ├── config/
│   │   │   │   │      SwaggerConfig.java
│   │   │   │   ├── controller/
│   │   │   │   │      ApiController.java
│   │   │   │   ├── dto/
│   │   │   │   │      DadosConsultaConteudos.java
│   │   │   │   │      DadosRespostaConteudo.java
│   │   │   │   ├── exception/
│   │   │   │   │      GlobalException.java
│   │   │   │   ├── model/
│   │   │   │   │      Conteudo.java
│   │   │   │   ├── repository/
│   │   │   │   │      ConteudoRepository.java
│   │   │   │   ├── service/
│   │   │   │   │      ConteudoService.java
│   │   │   │   │      ServiceDados.java
│   │   │   │   └── Team19Application.java
│   │   │   └── resources/
│   │   │          application.properties
│   │   │          db/migration/
│   ├── Dockerfile
│   ├── docker-compose.yml
│   └── pom.xml
│
└── README.md
```
<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 🔗 Integração com a API de IA

---

O backend comunica-se com a API desenvolvida pela equipe de Data Science para realizar a classificação automática de conteúdos técnicos.

###  🌐 API Pública

https://techmind-api.onrender.com


### 📖 Documentação Interativa
* **Backend Java (Spring Boot):** [Swagger UI](https://techmind-api.onrender.com/swagger-ui.html)
* **API de IA (FastAPI / Python):** [FastAPI Docs](https://techmind-api.onrender.com/docs)


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
No Frontend (app.js), a URL do backend pode ser configurada na constante global:

```JavaScript
const API_BASE_URL = 'http://localhost:8080';
```

### 🔹 Propriedades

| Propriedade | Descrição |
|------------|-----------|
| `model.python.url` | URL da API de Machine Learning utilizada pelo backend. |
| `model.python.mock-enabled` | Quando `true`, utiliza respostas simuladas para desenvolvimento. Quando `false`, envia requisições para a API FastAPI. |

## ▶️ Executando o Projeto

### 📋 Pré-requisitos

- Java 25
- Maven 3.9+
- Navegador Web moderno (Chrome, Firefox, Edge, Safari)
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

### 1. O Backend

```bash
./mvnw spring-boot:run
```

ou

```bash
mvn spring-boot:run
```
### O backend estará disponível em:

```
http://localhost:8080
```
### 2. O Frontend

Basta abrir o arquivo frontend/index.html em qualquer navegador web ou utilizar uma extensão como o Live Server no VS Code.

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 🧩 Implementação de Padrões de Projeto & Componentes

---

A aplicação foi desenhada seguindo as melhores práticas de desenvolvimento corporativo em Java e de interface Web, garantindo baixo acoplamento, alta coesão e facilidade de manutenção.

| Padrão / Componente | Implementação | Propósito |
| :--- | :--- | :--- |
| **Arquitetura SPA** | `view-landing`e `view-app em HTML/JS` | Transição sem recarregamento de página entre a Landing Page e o ecossistema do app.|
| **Efeito Flip Card 3D** | `#main-flip-card` com CSS `transform-style: preserve-3d` | Separação elegante entre a entrada de dados (Front face) e a exibição dos resultados da IA (Back face).|
| **Navegação por Abas** | `.nav-tabs e .tab-content` | Alternância dinâmica entre "Nova Análise", "Bibliotech" e "Métricas".|
| **Modais de Autenticação** | `#modal-login` e `#modal-register` | Interface de login e cadastro integrada com efeito visual escurecido (overlay).|
| **Padrão DTO** | `DadosConsultaConteudos`, `DadosRespostaConteudo` | Desacoplamento e segurança na trafegabilidade de dados entre a API Java, o cliente e os serviços externos. |
| **Camada de Serviço** | `ServiceDados` | Centraliza as regras de negócio do sistema, a orquestração de dados e a comunicação via HTTP Client. |
| **Camada de Persistência** | `ConteudoRepository` | Interface Spring Data JPA para comunicação e operações CRUD com o Banco de Dados. |
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

## 💾 Armazenamento e Persistência

---

A aplicação utiliza um **Banco de Dados Relacional (MySQL / PostgreSQL)** para a persistência definitiva de todos os conteúdos processados e categorizados pela inteligência artificial.

- **Mapeamento:** Jakarta Persistence (JPA / Hibernate)
- **Migrations:** Gerenciamento e versionamento do esquema de banco de dados via **Flyway** db/migration
- **Repositório:** `ConteudoRepository` executando consultas otimizadas no banco de dados.

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 📱 Aplicativo Mobile (Flutter)

---

A solução conta com uma versão mobile desenvolvida em **Flutter (Dart)**, garantindo uma experiência nativa para Android e iOS.

- **Interface Responsiva:** Consulta do acervo, filtro por tags e envio de análises em dispositivos móveis
- **Consumo de API:** Comunicação direta com o backend em nuvem via requisições HTTP assíncronas
- **Gerenciamento de Estado:** Arquitetura desacoplada para renderização ágil das telas

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

- Autenticação de usuários com Spring Security + JWT nos modais de Login/Cadastro
- Implementação de gráficos estatísticos na aba Métricas
- Cache de respostas para otimizar consultas da IA

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 👥 Equipes

---

### 🎨 Frontend & Mobile
- Desenvolvimento da Single Page Application (SPA Web) em Vanilla JS e CSS3 3D;
- Criação do aplicativo mobile multiplataforma em Flutter/Dart;
- Consumo assíncrono das APIs REST e gerenciamento visual da interface.

### 💻 Backend & DevOps
- Desenvolvimento da API RESTful em Spring Boot (Java 25);
- Modelagem e integração com Banco de Dados Relacional (JPA + Flyway);
- Mapeamento Swagger/OpenAPI e Deploy da infraestrutura na nuvem (Render/OCI).

### 🤖 Data Science
- Desenvolvimento e treinamento do modelo de Machine Learning em Python;
- Implementação da API FastAPI para extração de tags, resumos e categorização NLP.

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 📌 Status do Projeto

---

- ✅ Single Page Application (SPA Web) funcional com animação Flip Card 3D
- ✅ Aplicativo Mobile em Flutter funcional
- ✅ API REST em Spring Boot com validações e tratamento global de exceções
- ✅ Persistência definitiva em Banco de Dados Relacional via Spring Data JPA + Flyway
- ✅ Integração com a API de Machine Learning (FastAPI) em Nuvem e Modo Mock
- ✅ Documentação interativa configurada com Swagger UI e FastAPI Docs
- ✅ Deploy realizado em ambiente Cloud (Render)

<hr style="border: 0; height: 3px; background: #333; margin: 20px 0;">

## 📄 Licença

---

Projeto desenvolvido para fins acadêmicos durante o programa **No Country - Team 19**.

