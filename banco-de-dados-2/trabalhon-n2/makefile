# ==================================================================================== #
# VARIÁVEIS
# ==================================================================================== #

# Configurações do banco de dados
DB_USER ?= postgres
DB_PASSWORD ?= Alves@180204
DB_HOST ?= localhost
DB_PORT ?= 5432
DB_NAME ?= quizgame
DB_SSLMODE ?= disable

# String de conexão
DATABASE_URL = postgres://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST):$(DB_PORT)/$(DB_NAME)?sslmode=$(DB_SSLMODE)

# Diretórios
MIGRATIONS_DIR = db/migrations
SCHEMAS_DIR = db/schemas

# ==================================================================================== #
# DESENVOLVIMENTO
# ==================================================================================== #

.PHONY: help
help: ## Mostra esta mensagem de ajuda
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

.PHONY: run
run: ## Roda a aplicação
	go run main.go

.PHONY: build
build: ## Compila a aplicação
	go build -o bin/app main.go

# ==================================================================================== #
# BANCO DE DADOS - MIGRATIONS
# ==================================================================================== #

.PHONY: migrate-create
migrate-create: ## Cria uma nova migration (use name=nome_da_migration)
	@if [ -z "$(name)" ]; then \
		echo "❌ Erro: forneça um nome para a migration usando name=nome_da_migration"; \
		exit 1; \
	fi
	migrate create -ext sql -dir $(MIGRATIONS_DIR) -seq $(name)
	@echo "✅ Migration criada em $(MIGRATIONS_DIR)"

.PHONY: migrate-up
migrate-up: ## Executa todas as migrations pendentes
	@echo "🚀 Executando migrations..."
	migrate -path $(MIGRATIONS_DIR) -database "$(DATABASE_URL)" -verbose up
	@echo "✅ Migrations executadas com sucesso!"

.PHONY: migrate-down
migrate-down: ## Reverte a última migration
	@echo "⏪ Revertendo última migration..."
	migrate -path $(MIGRATIONS_DIR) -database "$(DATABASE_URL)" -verbose down 1
	@echo "✅ Migration revertida!"

.PHONY: migrate-down-all
migrate-down-all: ## Reverte todas as migrations
	@echo "⚠️  ATENÇÃO: Isso irá reverter TODAS as migrations!"
	@read -p "Tem certeza? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		migrate -path $(MIGRATIONS_DIR) -database "$(DATABASE_URL)" -verbose down -all; \
		echo "✅ Todas as migrations foram revertidas!"; \
	else \
		echo "❌ Operação cancelada."; \
	fi

.PHONY: migrate-force
migrate-force: ## Força uma versão específica (use version=N)
	@if [ -z "$(version)" ]; then \
		echo "❌ Erro: forneça uma versão usando version=N"; \
		exit 1; \
	fi
	migrate -path $(MIGRATIONS_DIR) -database "$(DATABASE_URL)" force $(version)
	@echo "✅ Versão forçada para $(version)"

.PHONY: migrate-version
migrate-version: ## Mostra a versão atual da migration
	@migrate -path $(MIGRATIONS_DIR) -database "$(DATABASE_URL)" version

.PHONY: migrate-status
migrate-status: ## Mostra o status das migrations
	@echo "📊 Status das migrations:"
	@migrate -path $(MIGRATIONS_DIR) -database "$(DATABASE_URL)" version || echo "Nenhuma migration aplicada"

# ==================================================================================== #
# SQLC
# ==================================================================================== #

.PHONY: sqlc-generate
sqlc-generate: ## Gera código Go a partir das queries SQL
	@echo "🔧 Gerando código SQLC..."
	sqlc generate
	@echo "✅ Código SQLC gerado com sucesso!"

.PHONY: sqlc-compile
sqlc-compile: ## Verifica se as queries SQL são válidas
	@echo "🔍 Validando queries SQL..."
	sqlc compile
	@echo "✅ Queries SQL válidas!"

.PHONY: sqlc-vet
sqlc-vet: ## Executa análise estática nas queries
	@echo "🔍 Analisando queries..."
	sqlc vet
	@echo "✅ Análise concluída!"

# ==================================================================================== #
# BANCO DE DADOS - OPERAÇÕES
# ==================================================================================== #

.PHONY: db-create
db-create: ## Cria o banco de dados
	@echo "🗄️  Criando banco de dados $(DB_NAME)..."
	psql -h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER) -c "CREATE DATABASE $(DB_NAME);" || echo "⚠️  Banco já existe"
	@echo "✅ Banco de dados criado!"

.PHONY: db-drop
db-drop: ## Remove o banco de dados
	@echo "⚠️  ATENÇÃO: Isso irá DELETAR o banco $(DB_NAME)!"
	@read -p "Tem certeza? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		psql -h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER) -c "DROP DATABASE IF EXISTS $(DB_NAME);"; \
		echo "✅ Banco de dados removido!"; \
	else \
		echo "❌ Operação cancelada."; \
	fi

.PHONY: db-reset
db-reset: db-drop db-create migrate-up ## Remove, recria e executa as migrations
	@echo "✅ Banco de dados resetado com sucesso!"

.PHONY: db-seed
db-seed: ## Popula o banco com dados de teste
	@echo "🌱 Populando banco de dados..."
	@go run db/seeds/seed.go
	@echo "✅ Dados de seed inseridos!"

# ==================================================================================== #
# DOCKER
# ==================================================================================== #

.PHONY: docker-up
docker-up: ## Sobe os containers do Docker
	docker-compose up -d
	@echo "✅ Containers iniciados!"

.PHONY: docker-down
docker-down: ## Para os containers do Docker
	docker-compose down
	@echo "✅ Containers parados!"

.PHONY: docker-logs
docker-logs: ## Mostra os logs dos containers
	docker-compose logs -f

# ==================================================================================== #
# TESTES
# ==================================================================================== #

.PHONY: test
test: ## Executa todos os testes
	go test -v ./...

.PHONY: test-coverage
test-coverage: ## Executa testes com cobertura
	go test -v -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out

# ==================================================================================== #
# LIMPEZA
# ==================================================================================== #

.PHONY: clean
clean: ## Remove arquivos temporários e binários
	rm -rf bin/
	rm -f coverage.out
	@echo "✅ Limpeza concluída!"

# ==================================================================================== #
# WORKFLOW COMPLETO
# ==================================================================================== #

.PHONY: setup
setup: db-create migrate-up sqlc-generate ## Setup inicial do projeto
	@echo "✅ Projeto configurado com sucesso!"

.PHONY: dev
dev: sqlc-generate run ## Gera código e roda a aplicação

.PHONY: fresh
fresh: db-reset sqlc-generate ## Reseta o banco e regenera o código
	@echo "✅ Ambiente atualizado!"