const router = require('express').Router();
const UserController = require("../controllers/user.controller.js");
const { verifyUser } = require('../middleware/verifyUser.js');
const PropertyRouter = require("./property.router");

router.post('/registration', UserController.register);
router.post('/login', UserController.login);
router.use('/bookings', verifyUser, PropertyRouter);
router.get('/getuser' , verifyUser, UserController.getUser);

module.exports = router;