const mongoose = require('mongoose');
const UserModel = require('../model/user.model');
const PropertyModel = require('../model/property.model');

const url = 'mongodb://localhost:27017/rolebaby';

const connect = () => {
  return new Promise((resolve, reject) => {
    mongoose
      .connect(url, { useNewUrlParser: true, useUnifiedTopology: true })
      .then(() => {
        console.log('MongoDB connected');

        // Make the Mongoose connection accessible from your models
        UserModel.connection = mongoose.connection;
        PropertyModel.connection = mongoose.connection;
        resolve();
      })
      .catch((error) => {
        console.error('MongoDB connection error', error);
        reject(error);
      });
  });
};

module.exports = {
  connect,
};
