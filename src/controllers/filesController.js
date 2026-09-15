/**
 * Controller para operações de arquivos
 */

const storageService = require('../services/storageService');

/**
 * POST /upload - Upload de arquivo
 * @route POST /upload
 * @access Public
 */
async function uploadFile(req, res) {
  try {
    if (!req.file) {
      return res.status(400).json({ error: 'Nenhum arquivo enviado' });
    }

    const result = await storageService.uploadFile(
      req.file.originalname,
      req.file.buffer,
      req.file.mimetype
    );

    res.status(201).json({
      message: 'Arquivo enviado com sucesso',
      data: result,
    });
  } catch (error) {
    console.error('Erro no upload:', error);
    res.status(500).json({ 
      error: 'Falha ao enviar arquivo',
      details: error.message 
    });
  }
}

/**
 * GET /files - Lista todos os arquivos
 * @route GET /files
 * @access Public
 */
async function listFiles(req, res) {
  try {
    const files = await storageService.listFiles();
    
    res.json({
      count: files.length,
      files,
    });
  } catch (error) {
    console.error('Erro ao listar arquivos:', error);
    res.status(500).json({ 
      error: 'Falha ao listar arquivos',
      details: error.message 
    });
  }
}

/**
 * GET /files/:name - Download de arquivo
 * @route GET /files/:name
 * @query mode - 'stream' (padrão) ou 'url' para presigned URL
 * @query expires - Tempo de expiração em segundos (apenas para mode=url)
 * @access Public
 */
async function getFile(req, res) {
  try {
    const { name } = req.params;
    const { mode = 'stream', expires } = req.query;

    if (mode === 'url') {
      const expiresIn = parseInt(expires) || parseInt(process.env.PRESIGNED_EXPIRY_SECONDS) || 3600;
      const url = await storageService.getPresignedUrl(name, expiresIn);
      
      return res.json({
        url,
        expiresIn,
        filename: name,
      });
    }

    // Modo stream (download direto)
    const fileStream = await storageService.getFileStream(name);
    
    // Configura headers para download
    res.setHeader('Content-Type', fileStream.ContentType || 'application/octet-stream');
    res.setHeader('Content-Disposition', `attachment; filename="${name}"`);
    
    // Stream do arquivo para o response
    fileStream.Body.pipe(res);
    
  } catch (error) {
    console.error('Erro ao obter arquivo:', error);
    
    if (error.name === 'NoSuchKey' || error.$metadata?.httpStatusCode === 404) {
      return res.status(404).json({ error: 'Arquivo não encontrado' });
    }
    
    res.status(500).json({ 
      error: 'Falha ao obter arquivo',
      details: error.message 
    });
  }
}

/**
 * DELETE /files/:name - Deleta um arquivo
 * @route DELETE /files/:name
 * @access Public
 */
async function deleteFile(req, res) {
  try {
    const { name } = req.params;
    
    await storageService.deleteFile(name);
    
    res.json({
      message: 'Arquivo deletado com sucesso',
      filename: name,
    });
  } catch (error) {
    console.error('Erro ao deletar arquivo:', error);
    
    if (error.name === 'NoSuchKey' || error.$metadata?.httpStatusCode === 404) {
      return res.status(404).json({ error: 'Arquivo não encontrado' });
    }
    
    res.status(500).json({ 
      error: 'Falha ao deletar arquivo',
      details: error.message 
    });
  }
}

module.exports = {
  uploadFile,
  listFiles,
  getFile,
  deleteFile,
};
