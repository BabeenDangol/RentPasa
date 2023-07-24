const express = require('express');
const bodyParser = require('body-parser');
const userRouter = require('./routers/user.router');
const propertyRouter = require('./routers/property.router');
const bookRouter = require('./routers/book.router');
const cors = require('cors');
const Property = require('./model/property.model');
const controller = require('./controllers/property.controller');
const app = express();
app.use(cors());
app.use(cors({
  origin: 'http://localhost:5173' // Replace with the URL of your frontend application
}));
app.use(bodyParser.json());
app.use('/', userRouter);
app.use('/', propertyRouter);
app.use('/', bookRouter);


  // Enable CORS with options
  app.use(cors({ origin: '*' }));

module.exports = app;