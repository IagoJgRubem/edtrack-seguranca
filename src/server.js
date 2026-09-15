/**
 * Servidor principal da API de armazenamento MinIO
 */

require('dotenv').config();
const express = require('express');
const filesRoutes = require('./routes/files');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware para parsing de JSON
app.use(express.json());

// Middleware de logging simples
app.use((req, res, next) => {
  const timestamp = new Date().toISOString();
  console.log(`[${timestamp}] ${req.method} ${req.path}`);
  next();
});

// Rotas da API
app.use('/api', filesRoutes);
app.use('/', filesRoutes); // alias: /upload, /files, /files/:name conforme especificação

// Health check
app.get('/health', (req, res) => {
  res.json({ 
    status: 'ok', 
    service: 'minio-storage-api',
    timestamp: new Date().toISOString(),
  });
});

// Rota raiz com documentação básica
app.get('/', (req, res) => {
  res.json({
    service: 'MinIO Storage API',
    version: '1.0.0',
    endpoints: {
      upload: 'POST /api/upload',
      listFiles: 'GET /api/files',
      getFile: 'GET /api/files/:name',
      deleteFile: 'DELETE /api/files/:name',
      health: 'GET /health',
    },
    documentation: 'Consulte README.md e docs/artigo.md',
  });
});

// Handler de erros global
app.use((err, req, res, next) => {
  console.error('Erro não tratado:', err);
  res.status(500).json({
    error: 'Erro interno do servidor',
    message: process.env.NODE_ENV === 'development' ? err.message : undefined,
  });
});

// Inicia o servidor
app.listen(PORT, () => {
  console.log('='.repeat(50));
  console.log('MinIO Storage API');
  console.log('='.repeat(50));
  console.log(`Servidor rodando em: http://localhost:${PORT}`);
  console.log(`API endpoints: http://localhost:${PORT}/api`);
  console.log(`Health check: http://localhost:${PORT}/health`);
  console.log('='.repeat(50));
});

module.exports = app;
