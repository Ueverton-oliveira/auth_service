# Authenticate Microservice

Este é o microserviço de autenticação, responsável por gerenciar o registro, login e validação de tokens de usuários. Ele interage com uma API de autenticação externa utilizando `HTTParty`.

## Requisitos

Antes de começar, certifique-se de ter os seguintes requisitos instalados:

- Ruby 3.x
- Rails 7.x
- PostgreSQL 13.x ou superior
- Node.js 16.x ou superior
- Yarn
- Docker e Docker Compose (opcional)

## Configuração Manual

### 1. Clone o Repositório

```bash
git clone https://github.com/usuario/authenticate-service.git
cd authenticate-service
```

### 2. Instale as Dependências

Instale as dependências do projeto:

```bash
bundle install
yarn install
```

### 3. Configure o Banco de Dados

Crie o arquivo `config/database.yml` com as configurações do seu banco de dados. Um exemplo básico:

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: 5
  username: seu_usuario
  password: sua_senha
  host: localhost

development:
  <<: *default
  database: authenticate_service_development

test:
  <<: *default
  database: authenticate_service_test

production:
  <<: *default
  database: authenticate_service_production
  username: seu_usuario_producao
  password: sua_senha_producao
```

### 4. Prepare o Banco de Dados

Crie e execute as migrações do banco de dados:

```bash
rails db:create
rails db:migrate
```

### 5. Configuração de Variáveis de Ambiente

Crie um arquivo `.env` na raiz do projeto para configurar as variáveis de ambiente necessárias, como chaves de API e outros dados sensíveis.

Exemplo de `.env`:

```
AUTH_API_KEY=suachaveapi
SECRET_KEY=suachavesecreta
```

### 6. Executando o Servidor

Inicie o servidor Rails:

```bash
rails server
```

Acesse o microserviço em `http://localhost:3000`.

## Configuração com Docker

### 1. Clone o Repositório

```bash
git clone https://github.com/usuario/authenticate-service.git
cd authenticate-service
```

### 2. Configurar as Variáveis de Ambiente

Crie um arquivo `.env` com as configurações necessárias, como no exemplo anterior.

### 3. Build e Inicialize os Contêineres

Use o Docker Compose para criar e iniciar os contêineres:

```bash
docker-compose up --build
```

Este comando irá construir as imagens necessárias e iniciar os serviços do Docker.

### 4. Setup do Banco de Dados

Após inicializar os contêineres, execute as migrações dentro do contêiner:

```bash
docker-compose exec web rails db:create db:migrate
```

### 5. Acessar o Microserviço

O microserviço estará disponível em `http://localhost:3000`.

## Testes

Para rodar os testes, use o seguinte comando:

### Configuração Manual

```bash
rails test
```
<img width="469" alt="image" src="https://github.com/user-attachments/assets/cceabcb7-c322-48fc-868a-caad83b7d63f">


### Com Docker

```bash
docker-compose exec web rails test
```

## Contribuição

Contribuições são bem-vindas! Por favor, faça um fork do repositório e abra uma pull request com suas alterações.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

