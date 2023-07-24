const express = require('express');
const bodyParser = require('body-parser');
const userRouter = require('./routers/user.router');
const bookingsRouter = require('./routers/bookings.router');
const cors = require('cors');
const { url } = require('inspector');


const app = express();
app.use(cors());
app.use(cors({
  origin: 'http://localhost:5173' // Replace with the URL of your frontend application
}));
app.use(
  express.urlencoded({ extended: true })
);
app.use(express.json());
app.use(bodyParser.json());
app.use('/user', userRouter);
app.use('/booking', bookingsRouter);


  // Enable CORS with options
  app.use(cors({ origin: '*' }));

module.exports = app;