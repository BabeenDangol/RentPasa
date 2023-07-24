const mongoose = require('mongoose');

const { Schema } = mongoose;

const bookSchema = new mongoose.Schema({
  userId: {type: String},
  userName: {type: String},
  propertyAddress: { type: String, required: true },
  propertyLocality: { type: String, required: true },
  propertyRent: { type: Number, required: true },
  propertyType: { type: String, required: true },
  propertyBalconyCount: { type: Number, required: true },
  propertyBedroomCount: { type: Number, required: true },
  propertyDate: { type: Date, required: true },
  bookingRemaining: { type: Number },
  propertyDescriptions: {
    type: String,
    // required: true,
  },
});

module.exports = mongoose.model('Book', bookSchema);