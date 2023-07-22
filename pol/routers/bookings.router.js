const router = require('express').Router();
const BookingsController = require('../controllers/bookings.controller.js');
const BookController = require('../controllers/book.controller.js');

router.post('/bookings', BookingsController.createBooking);
router.post('/createBook', BookController.createBooking);
router.get('/getbooking' , BookingsController.getBooking);
router.get('/getbooks' , BookingsController.getBooks);

module.exports = router;
