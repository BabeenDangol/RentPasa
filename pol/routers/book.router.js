const express = require('express');
const router = express.Router();
const UserController = require('../controllers/user.controller.js');
const BookingsRouter = require('./bookings.router.js');
const { verifyUser } = require('../middleware/verifyUser.js');

router.post('/registration', UserController.register);
router.post('/login', UserController.login);

router.use('/bookings', verifyUser, BookingsRouter);

module.exports = router;