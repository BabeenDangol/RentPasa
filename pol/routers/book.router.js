const express = require('express');
const router = express.Router();
const UserController = require('../controllers/user.controller.js');
const PropertyRouter = require('./property.router.js');
const { verifyUser } = require('../middleware/verifyUser.js');

router.post('/registration', UserController.register);
router.post('/login', UserController.login);
// router.use('/property', verifyUser, PropertyRouter);
 router.use('/property', verifyUser, PropertyRouter);

module.exports = router;