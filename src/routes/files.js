/**
 * Rotas para operações com arquivos
 */

const express = require('express');
const multer = require('multer');
const filesController = require('../controllers/filesController');

const router = express.Router();

// Configuração do multer para armazenamento em memória (stream)
const storage = multer.memoryStorage();
const upload = multer({ 
  storage,
  limits: {
    fileSize: 50 * 1024 * 1024, // Limite de 50MB
  },
});

/**
 * @route POST /upload
 * @desc Upload de arquivo para o MinIO
 * @access Public
 * @body file - Arquivo multipart/form-data
 */
router.post('/upload', upload.single('file'), filesController.uploadFile);

/**
 * @route GET /files
 * @desc Lista todos os arquivos armazenados
 * @access Public
 */
router.get('/files', filesController.listFiles);

/**
 * @route GET /files/:name
 * @desc Download de arquivo específico
 * @query mode - 'stream' (padrão) ou 'url' para URL presignada
 * @query expires - Tempo de expiração em segundos (apenas mode=url)
 * @access Public
 */
router.get('/files/:name', filesController.getFile);

/**
 * @route DELETE /files/:name
 * @desc Deleta um arquivo específico
 * @access Public
 */
router.delete('/files/:name', filesController.deleteFile);

module.exports = router;
