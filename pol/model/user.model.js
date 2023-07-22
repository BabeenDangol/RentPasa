const mongoose = require('mongoose');
const bcrypt = require("bcrypt");

const { Schema } = mongoose;

const userSchema = new Schema({
  names: {
    type: String,
    required: true,
  },
  phone: {
    type: Number,
    required: true,
    unique: true,
  },
  email: {
    type: String,
    lowercase: true,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  role: {
    type: String,
    required: true,
  }
});

userSchema.pre('save', async function(){
  try {
    var user = this;
    const salt = await (bcrypt.genSalt(10));
    const hashpass = await bcrypt.hash(user.password,salt);
    user.password = hashpass;
  } catch(error) {
    throw error;
  }
});

userSchema.methods.comparePassword = async function(userPassword){
  try {
    const isMatch = await bcrypt.compare(userPassword, this.password);
    return isMatch;
  } catch (error) {
    throw error;
  }
}
const bookingsSchema = new Schema({
  propertyName: {
    type: String,
    required: true,
  },
  propertyAddress: {
    type: String,
    required: true,
  },
  propertyRent: {
    type: Number,
    required: true,
  },
  propertyDate: {
    type: Date,
    required: true,
  },
  propertyType: {
    type: String,
    required: true,
  },
  propertyBalconyCount: {
    type: Number,
    required: true,
  },
  propertyBedroomCount: {
    type: Number,
    required: true,
  },
  propertyImage: {
    data: Buffer,
    contentType: String
  },
  user_id: { 
    type: Schema.Types.ObjectId, 
    ref: 'User' 
  }
});

const UserModel = mongoose.model('User', userSchema);
const BookingsModel = mongoose.model('Booking', bookingsSchema);

module.exports = { UserModel, BookingsModel };