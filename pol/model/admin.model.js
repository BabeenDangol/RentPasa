const mongoose = require('mongoose');
const bcrypt = require("bcrypt");

const { Schema } = mongoose;

const adminSchema = new mongoose.Schema({
  names: {
    type: String,
    required: true,
    trim: true,
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
    trim: true
  },
  password: {
    type: String,
    required: true,
  },
});

adminSchema.pre('save', async function(){
  try {
    let admin = this;
    const salt = await (bcrypt.genSalt(10));
    const hashpass = await bcrypt.hash(admin.password,salt);
    admin.password = hashpass;
  } catch(error) {
    throw error;
  }
});

adminSchema.methods.comparePassword = async function(adminPassword){
  try {
    const isMatch = await bcrypt.compare(adminPassword, this.password);
    return isMatch;
  } catch (error) {
    throw error;
  }
}
const AdminModel = mongoose.model('admin', adminSchema);
module.exports = { AdminModel };