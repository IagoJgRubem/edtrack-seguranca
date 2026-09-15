/**
 * Configuração do cliente MinIO/S3
 * Utiliza AWS SDK v3 para compatibilidade com MinIO
 */

const { S3Client } = require('@aws-sdk/client-s3');
require('dotenv').config();

const s3Client = new S3Client({
  region: process.env.MINIO_REGION || 'us-east-1',
  endpoint: `http://${process.env.MINIO_ENDPOINT}:${process.env.MINIO_PORT}`,
  credentials: {
    accessKeyId: process.env.MINIO_ROOT_USER,
    secretAccessKey: process.env.MINIO_ROOT_PASSWORD,
  },
  forcePathStyle: true, // Necessário para MinIO
});

const BUCKET_NAME = process.env.MINIO_BUCKET || 'storage-bucket';

module.exports = {
  s3Client,
  BUCKET_NAME,
};
