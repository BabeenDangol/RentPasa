const mongoose = require('mongoose');

const { Schema } = mongoose;

const bookingsSchema = new mongoose.Schema({
  
  propertyAddress: {
    type: String,
    // required: true,
  },
  propertyLocality: { 
    type: String, //required: true
 },
  propertyRent: {
    type: Number,
    // required: true,
  },
  propertyType: {
    type: String,
    // required: true,
  },
  propertyBalconyCount: {
    type: Number,
    // required: true,
  },
  propertyBedroomCount: {
    type: Number,
    // required: true,
  },
  propertyDate: {
    type: Date,
    // required: true,
  },
  propertyDescriptions: {
    type: String,
    // required: true,
  },
  bookingRemaining: { type: Number, default: 3 },
  ownerId: { type: Schema.Types.ObjectId, ref: 'User' },
});

module.exports = mongoose.model('Bookings', bookingsSchema);
