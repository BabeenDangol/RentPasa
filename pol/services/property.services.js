
const BookModel = require("../model/book.model.js");

const PropertyModel = require('../model/property.model.js');
class PropertyService {
  // Create a new booking
  static async createProperty(
    propertyAddress,
    ownerName,
    ownerId,
    propertyLocality,
    propertyRent,
    propertyType,
    propertyBalconyCount,
    propertyBedroomCount,
    propertyDate,
    propertyDescriptions
  ) {
    try {
      const property = new PropertyModel({
        propertyAddress,
        ownerName,
        ownerId,
        propertyLocality,
        propertyRent,
        propertyType,
        propertyBalconyCount,
        propertyBedroomCount,
        propertyDate,
        propertyDescriptions,
      });
      return await property.save();
    } catch (error) {
      throw error;
    }
  }
  static async getProperty() {
    try {
      return await PropertyModel.find();
    } catch (error) {
      throw error;
    }
  }
  //get all the Bookings.
  static async getBooks() {
    try {
      return await BookModel.find();
    } catch (error) {
      throw error;
    }
  }

  // Get a specific booking by ID
  static async getBookingById(bookingId) {
    try {
      return await PropertyModel.findById(bookingId);
    } catch (error) {
      throw error;
    }
  }
}

module.exports = PropertyService;
