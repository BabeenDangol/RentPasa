const express = require('express');
const router = express.Router();
const UserController = require('../controllers/user.controller.js');
const BookingsRouter = require('./bookings.router.js');

router.post('/registration', UserController.register);
router.post('/login', UserController.login);

router.use('/bookings', BookingsRouter);

module.exports = router;