const express = require('express');
const bodyParser = require('body-parser');
const userRouter = require('./routers/user.router');
const adminRouter = require('./routers/admin.router');

const bookRouter = require('./routers/book.router');
// const bookingsRouter = require('./routers/bookings.router');
const propertyRouter = require('./routers/property.router');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const { url } = require('inspector');


const app = express();
app.use(cors({
  origin: '*' // Replace with the URL of your frontend application
}));
app.use(
  express.urlencoded({ extended: true })
);
app.use(express.json());
app.use(bodyParser.json());
app.use(cookieParser());

app.use('/user', userRouter);
app.use('/admin', adminRouter);

// app.use('/booking', bookingsRouter);
app.use('/property', propertyRouter);
app.use('/book', bookRouter);



module.exports = app;