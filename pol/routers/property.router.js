const router = require('express').Router();
const PropertyController = require('../controllers/property.controller.js');
const BookController = require('../controllers/book.controller.js');

router.post('/property', PropertyController.createProperty);
router.post('/createBook', BookController.createBook);
router.get('/getproperty' , PropertyController.getProperty);
router.get('/getbooks' , PropertyController.getBooks);

module.exports = router;
