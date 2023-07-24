const BookingService = require('../services/bookings.services.js');

// Create a new booking
exports.createBooking = async (req, res, next) => {
  try {
    const { propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate,propertyDescriptions} = req.body;
    const booking = await BookingService.createBooking(propertyAddress, propertyLocality, propertyRent, propertyType, propertyBalconyCount, propertyBedroomCount, propertyDate, propertyDescriptions);
    res.status(201).json({ status: true, success: "Booking created successfully", booking });
  } catch (error) {
    next(error);
  }
};
exports.getBooking = async (req, res, next) => {
  try {
    const booking = await BookingService.getBooking();
    res.status(200).json({ status: true, booking });
  } catch (error) {
    next(error);
  }
};
exports.getBooks = async (req, res, next) => {
  try {
    const getbooks = await BookingService.getBooks();
    res.status(200).json({ status: true, getbooks});
  } catch (error) {
    next(error);
  }
};