#!/bin/bash
# Script de demonstração da API MinIO Storage
# Execute após: docker compose up -d && npm install && npm run dev

set -e

BASE_URL="http://localhost:3000/api"
TEST_FILE="/tmp/teste_minio.txt"

echo "=============================================="
echo "MinIO Storage API - Script de Demonstração"
echo "=============================================="

# Cria arquivo de teste
echo "Criando arquivo de teste..."
echo "Conteúdo gerado em $(date)" > "$TEST_FILE"
echo "Arquivo criado: $TEST_FILE"

# Aguarda API estar disponível
echo ""
echo "Aguardando API ficar disponível..."
for i in {1..30}; do
  if curl -s http://localhost:3000/health > /dev/null 2>&1; then
    echo "API disponível!"
    break
  fi
  if [ $i -eq 30 ]; then
    echo "ERRO: API não respondeu em 30 segundos"
    exit 1
  fi
  sleep 1
done

# Teste 1: Health Check
echo ""
echo "=== TESTE 1: Health Check ==="
curl -s http://localhost:3000/health | jq .
echo ""

# Teste 2: Upload
echo "=== TESTE 2: Upload de Arquivo ==="
UPLOAD_RESPONSE=$(curl -s -X POST "$BASE_URL/upload" \
  -F "file=@$TEST_FILE")
echo "$UPLOAD_RESPONSE" | jq .
echo ""

# Teste 3: Listar arquivos
echo "=== TESTE 3: Listar Arquivos ==="
LIST_RESPONSE=$(curl -s "$BASE_URL/files")
echo "$LIST_RESPONSE" | jq .
echo ""

# Extrai nome do arquivo para próximos testes
FILENAME=$(echo "$LIST_RESPONSE" | jq -r '.files[0].name')
echo "Arquivo para testes: $FILENAME"

# Teste 4: Download (stream)
echo ""
echo "=== TESTE 4: Download (Stream Direto) ==="
DOWNLOAD_START=$(date +%s.%N)
curl -s -o "/tmp/download_$FILENAME" "$BASE_URL/files/$FILENAME"
DOWNLOAD_END=$(date +%s.%N)
DOWNLOAD_TIME=$(echo "$DOWNLOAD_END - $DOWNLOAD_START" | bc)
echo "Download concluído em ${DOWNLOAD_TIME}s"
echo "Conteúdo baixado:"
cat "/tmp/download_$FILENAME"
echo ""

# Teste 5: URL Presignada
echo "=== TESTE 5: URL Presignada ==="
PRESIGNED_RESPONSE=$(curl -s "$BASE_URL/files/$FILENAME?mode=url&expires=3600")
echo "$PRESIGNED_RESPONSE" | jq .
echo ""

# Teste 6: Download via URL presignada
echo "=== TESTE 6: Download via URL Presignada ==="
PRESIGNED_URL=$(echo "$PRESIGNED_RESPONSE" | jq -r '.url')
curl -s -o "/tmp/presigned_$FILENAME" "$PRESIGNED_URL"
echo "Download via presigned URL concluído"
echo "Conteúdo:"
cat "/tmp/presigned_$FILENAME"
echo ""

# Teste 7: Deletar arquivo
echo "=== TESTE 7: Deletar Arquivo ==="
DELETE_RESPONSE=$(curl -s -X DELETE "$BASE_URL/files/$FILENAME")
echo "$DELETE_RESPONSE" | jq .
echo ""

# Verifica se foi deletado
echo "=== Verificação Final ==="
FINAL_LIST=$(curl -s "$BASE_URL/files")
echo "Arquivos restantes:"
echo "$FINAL_LIST" | jq '.files'

# Limpeza
rm -f "$TEST_FILE" "/tmp/download_$FILENAME" "/tmp/presigned_$FILENAME"

echo ""
echo "=============================================="
echo "Todos os testes concluídos com sucesso!"
echo "=============================================="
