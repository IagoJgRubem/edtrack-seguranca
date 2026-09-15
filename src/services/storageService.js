/**
 * Serviço de armazenamento - operações com MinIO/S3
 */

const { 
  PutObjectCommand, 
  GetObjectCommand, 
  ListObjectsV2Command,
  DeleteObjectCommand,
  HeadObjectCommand
} = require('@aws-sdk/client-s3');
const { getSignedUrl } = require('@aws-sdk/s3-request-presigner');
const { s3Client, BUCKET_NAME } = require('../config/minio');

/**
 * Upload de arquivo para o bucket
 * @param {string} key - Nome do arquivo no bucket
 * @param {Buffer} body - Conteúdo do arquivo como Buffer
 * @param {string} contentType - Tipo MIME do arquivo
 * @returns {Promise<object>} - Metadados do upload
 */
async function uploadFile(key, body, contentType) {
  const command = new PutObjectCommand({
    Bucket: BUCKET_NAME,
    Key: key,
    Body: body,
    ContentType: contentType,
  });

  await s3Client.send(command);
  
  return {
    key,
    bucket: BUCKET_NAME,
    uploadedAt: new Date().toISOString(),
  };
}

/**
 * Lista todos os arquivos do bucket
 * @returns {Promise<Array>} - Lista de metadados dos arquivos
 */
async function listFiles() {
  const command = new ListObjectsV2Command({
    Bucket: BUCKET_NAME,
  });

  const response = await s3Client.send(command);
  
  if (!response.Contents) {
    return [];
  }

  return Promise.all(response.Contents.map(async (obj) => {
    const head = await s3Client.send(new HeadObjectCommand({ Bucket: BUCKET_NAME, Key: obj.Key }));
    return {
      name: obj.Key,
      size: obj.Size,
      lastModified: obj.LastModified.toISOString(),
      contentType: head.ContentType,
      etag: obj.ETag,
    };
  }));
}

/**
 * Obtém arquivo como stream para download
 * @param {string} key - Nome do arquivo no bucket
 * @returns {Promise<GetObjectOutput>} - Stream do arquivo
 */
async function getFileStream(key) {
  const command = new GetObjectCommand({
    Bucket: BUCKET_NAME,
    Key: key,
  });

  return await s3Client.send(command);
}

/**
 * Gera URL presignada para download temporário
 * @param {string} key - Nome do arquivo no bucket
 * @param {number} expiresIn - Tempo de expiração em segundos
 * @returns {Promise<string>} - URL presignada
 */
async function getPresignedUrl(key, expiresIn = 3600) {
  const command = new GetObjectCommand({
    Bucket: BUCKET_NAME,
    Key: key,
  });

  return await getSignedUrl(s3Client, command, { expiresIn });
}

/**
 * Deleta um arquivo do bucket
 * @param {string} key - Nome do arquivo no bucket
 * @returns {Promise<object>} - Resultado da operação
 */
async function deleteFile(key) {
  const command = new DeleteObjectCommand({
    Bucket: BUCKET_NAME,
    Key: key,
  });

  await s3Client.send(command);
  
  return { deleted: key, bucket: BUCKET_NAME };
}

module.exports = {
  uploadFile,
  listFiles,
  getFileStream,
  getPresignedUrl,
  deleteFile,
};
