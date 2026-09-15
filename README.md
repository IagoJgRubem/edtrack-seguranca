# MinIO Storage API

API de armazenamento de objetos usando **MinIO** e **Node.js** com Express. Esta solução implementa um serviço de Object Storage compatível com S3, permitindo upload, listagem, download (stream ou URL presignada) e exclusão de arquivos.

## 📋 Pré-requisitos

- **Node.js** v20+ ([instalação](https://nodejs.org/))
- **Docker** e **Docker Compose** ([instalação](https://docs.docker.com/get-docker/))
- **jq** (opcional, para formatar saída JSON nos testes)

## 🚀 Quick Start

### 1. Clone o repositório

```bash
git clone https://github.com/IagoJgRubem/edtrack-seguranca.git
cd edtrack-seguranca
```

### 2. Configure as variáveis de ambiente

```bash
cp .env.example .env
```

Edite `.env` se necessário:

```env
PORT=3000
MINIO_ENDPOINT=localhost
MINIO_PORT=9000
MINIO_ROOT_USER=minioadmin
MINIO_ROOT_PASSWORD=minioadmin123
MINIO_BUCKET=storage-bucket
PRESIGNED_EXPIRY_SECONDS=3600
```

### 3. Inicie o MinIO com Docker

```bash
docker compose up -d
```

O MinIO estará disponível em:
- **API**: http://localhost:9000
- **Console Web**: http://localhost:9001 (login: `minioadmin` / senha: `minioadmin123`)

### 4. Instale as dependências Node.js

```bash
npm install
```

### 5. Inicie a API

```bash
# Modo desenvolvimento (auto-reload)
npm run dev

# Ou modo produção
npm start
```

A API estará disponível em http://localhost:3000

## 📡 Endpoints da API

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/health` | Health check do serviço |
| `POST` | `/api/upload` | Upload de arquivo (multipart/form-data) |
| `GET` | `/api/files` | Lista todos os arquivos |
| `GET` | `/api/files/:name` | Download de arquivo específico |
| `DELETE` | `/api/files/:name` | Deleta um arquivo |

### Exemplos cURL

#### Health Check
```bash
curl http://localhost:3000/health
```

#### Upload de Arquivo
```bash
curl -X POST http://localhost:3000/api/upload \
  -F "file=@/caminho/para/seu/arquivo.pdf"
```

#### Listar Arquivos
```bash
curl http://localhost:3000/api/files
```

#### Download (Stream Direto)
```bash
curl -o arquivo_baixado.pdf http://localhost:3000/api/files/meu_arquivo.pdf
```

#### Download (URL Presignada)
```bash
curl "http://localhost:3000/api/files/meu_arquivo.pdf?mode=url&expires=3600"
```

#### Deletar Arquivo
```bash
curl -X DELETE http://localhost:3000/api/files/meu_arquivo.pdf
```

## 🧪 Testes

### Opção 1: Script de Demonstração

Execute o script completo que testa todos os endpoints:

```bash
./scripts/demo.sh
```

### Opção 2: VS Code REST Client

Instale a extensão [REST Client](https://marketplace.visualstudio.com/items?itemName=humao.rest-client) e abra `tests/storage-api.http`. Execute cada request com `Ctrl+Enter`.

### Opção 3: Postman

Importe a coleção `postman/minio-storage-api.postman_collection.json` no Postman.

## 🏗️ Arquitetura

```
┌─────────────┐     ┌──────────────────┐     ┌─────────────┐
│   Cliente   │────▶│   API Node.js    │────▶│    MinIO    │
│  (HTTP/cURL)│     │   (Express + SDK)│     │  (S3 Compat)│
└─────────────┘     └──────────────────┘     └─────────────┘
                           │
                    ┌──────▼──────┐
                    │   Multer    │
                    │ (Middleware)│
                    └─────────────┘
```

### Componentes

- **src/server.js**: Servidor Express principal
- **src/routes/files.js**: Definição das rotas da API
- **src/controllers/filesController.js**: Lógica de controle das requisições
- **src/services/storageService.js**: Operações com MinIO/S3
- **src/config/minio.js**: Configuração do cliente S3

## 🔧 Troubleshooting

### Erro: "Bucket not found"
Verifique se o container `minio-init` executou corretamente:
```bash
docker compose logs minio-init
```

### Erro: "Connection refused" no MinIO
Certifique-se que o MinIO está rodando:
```bash
docker compose ps
docker compose logs minio
```

### Erro: "File too large"
O limite padrão é 50MB. Ajuste em `src/routes/files.js`:
```javascript
limits: { fileSize: 100 * 1024 * 1024 } // 100MB
```

### API não responde
Verifique se a porta 3000 não está em uso:
```bash
lsof -i :3000
```

## 📄 Estrutura do Projeto

```
/
├── README.md
├── .gitignore
├── .env.example
├── docker-compose.yml
├── package.json
├── src/
│   ├── server.js
https://github.com/IagoJgRubem/edtrack-seguranca/pull/2/conflict?name=README.md&ancestor_oid=3043bb4c68d24fd32982d7d4e478049a424a78d2&base_oid=7a206295e572603c7786d523b5bb639ea8986db5&head_oid=b1c19b1ff65f0741a5d76638ef54ce6e51a96558│   ├── config/minio.js
│   ├── routes/files.js
│   ├── controllers/filesController.js
│   └── services/storageService.js
├── tests/
│   └── storage-api.http
├── postman/
│   └── minio-storage-api.postman_collection.json
├── scripts/
│   └── demo.sh
└── docs/
    └── artigo.md
```

## 📝 Licença

MIT

## 👥 Autores
## 👥 Autores

- **Iago Nunes** — [responsabilidade: ex., infraestrutura Docker/MinIO]
- **Lucas Moura** — [responsabilidade: ex., API Node.js e endpoints]
- [Integrante 3, se houver] — [responsabilidade]
- [Integrante 4, se houver] — [responsabilidade]

Desenvolvido como parte das notas das disciplinas de Devops e Auditoria e Segurança da Informação.
Desenvolvido como parte da disciplina de Armazenamento em Nuvem.
