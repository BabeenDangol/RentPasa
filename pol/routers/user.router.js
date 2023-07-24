const router = require('express').Router();
const UserController = require("../controllers/user.controller.js");
const PropertyRouter = require('./property.router');

router.post('/registration', UserController.register);
router.post('/login', UserController.login);
router.use('/bookings', PropertyRouter);
router.get('/getuser' , UserController.getUser);

module.exports = router;