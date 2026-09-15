const express = require('express');
const multer = require('multer');
const minio = require('minio');

const app = express();
const PORT = process.env.PORT || 3000;

const minioClient = new minio.Client({
  endPoint: process.env.MINIO_ENDPOINT || 'localhost',
  port: parseInt(process.env.MINIO_PORT) || 9000,
  useSSL: false,
  accessKey: process.env.MINIO_ROOT_USER || 'minioadmin',
  secretKey: process.env.MINIO_ROOT_PASSWORD || 'minioadmin123'
});

const BUCKET = process.env.MINIO_BUCKET || 'uploads';
const PRESIGNED_EXPIRY = parseInt(process.env.PRESIGNED_EXPIRY_SECONDS) || 3600;

const upload = multer({ storage: multer.memoryStorage() });

app.post('/upload', upload.single('file'), async (req, res) => {
  try {
    if (!req.file) return res.status(400).json({ error: 'Nenhum arquivo enviado' });
    
    await minioClient.putObject(BUCKET, req.file.originalname, req.file.buffer, req.file.size);
    res.json({ message: 'Upload realizado com sucesso', filename: req.file.originalname, size: req.file.size });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.get('/files', async (req, res) => {
  try {
    const files = [];
    const stream = minioClient.listObjects(BUCKET, '', true);
    
    for await (const obj of stream) {
      files.push({
        name: obj.name,
        size: obj.size,
        lastModified: obj.lastModified,
        contentType: obj.contentType || 'unknown'
      });
    }
    res.json(files);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.get('/files/:filename', async (req, res) => {
  try {
    const { filename } = req.params;
    const mode = req.query.mode || 'stream';
    
    if (mode === 'url') {
      const url = await minioClient.presignedGetObject(BUCKET, filename, PRESIGNED_EXPIRY);
      return res.json({ url, expires_in: PRESIGNED_EXPIRY });
    }
    
    const stream = await minioClient.getObject(BUCKET, filename);
    res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
    stream.pipe(res);
  } catch (err) {
    res.status(404).json({ error: 'Arquivo não encontrado' });
  }
});

app.listen(PORT, () => {
  console.log(`API rodando na porta ${PORT}`);
});
