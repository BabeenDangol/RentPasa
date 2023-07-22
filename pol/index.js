const app = require('./app');
const db = require('./config/db');
const port = 3000;

// Connect to the database
db.connect().then(() => {
  console.log('Connected to MongoDB');

  // Start listening for incoming requests
  app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
  });
}).catch((error) => {
  console.error('Error connecting to MongoDB', error);
});