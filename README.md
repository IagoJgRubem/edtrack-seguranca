# MinIO Storage API

API Node.js para armazenamento de objetos usando MinIO.

## Como rodar

```bash
cp .env.example .env
docker compose up -d
npm install
npm run dev
```

## Rotas

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | `/upload` | Upload de arquivo (multipart/form-data) |
| GET | `/files` | Lista todos os arquivos |
| GET | `/files/:filename` | Download do arquivo |
| GET | `/files/:filename?mode=url` | URL presigned |

## Exemplos curl

```bash
curl -X POST -F "file=@teste.txt" http://localhost:3000/upload
curl http://localhost:3000/files
curl http://localhost:3000/files/teste.txt -o teste.txt
curl "http://localhost:3000/files/teste.txt?mode=url"
```
