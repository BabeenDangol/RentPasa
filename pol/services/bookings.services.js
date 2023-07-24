const BookingsModel = require('../model/bookings.model.js');
const BookModel = require('../model/book.model.js');

class BookingsService {
  // Create a new booking
  static async createBooking(propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate,propertyDescriptions) {
    try {
      const booking = new BookingsModel({ propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate,propertyDescriptions });
      return await booking.save();
    } catch (error) {
      throw error;
    }
  }
  static async getBooking() {
    try {
      return await BookingsModel.find();
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
      return await BookingsModel.findById(bookingId);
    } catch (error) {
      throw error;
    }
  }
}

module.exports = BookingsService;
