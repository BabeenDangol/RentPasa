const multer = require('multer');
const path = require('path');
const fs = require('fs');

const upload = multer({ dest: 'public/uploads' });

function generateRandomInt() {
  return Math.floor(Math.random() * 1000000);
}

function renameFile(req, file, cb) {
  const randomInt = generateRandomInt();
  const fileExtension = path.extname(file.originalname);
  const newFilename = `${randomInt}${fileExtension}`;
  cb(null, newFilename);
}

const fileUploadMiddleware = upload.single('file');

fileUploadMiddleware.fileFilter = (req, file, cb) => {
  cb(null, true);
};

fileUploadMiddleware.storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'public/uploads');
  },
  filename: renameFile
});

module.exports = fileUploadMiddleware;
