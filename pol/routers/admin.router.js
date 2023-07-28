const router = require('express').Router();
const AdminController = require("../controllers/admin.controller.js");
const { verifyUser } = require('../middleware/verifyUser.js');
const PropertyRouter = require("./property.router");

router.post('/adminregistration', AdminController.register);
router.post('/adminlogin', AdminController.login);
router.use('/bookings', verifyUser, PropertyRouter);


module.exports = router;